#!/usr/bin/env bash
# Claude Code statusline (minimal, no font dependency)
# Reads JSON from stdin and prints a 2-line status to stdout.

set -u

# --- Colors -----------------------------------------------------------------
RESET=$'\033[0m'
DIM=$'\033[2m'
BOLD=$'\033[1m'
RED=$'\033[31m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
BLUE=$'\033[34m'
MAGENTA=$'\033[35m'
CYAN=$'\033[36m'

SEP="${DIM} | ${RESET}"
SEP2="${DIM} · ${RESET}"

# --- Read input -------------------------------------------------------------
input=$(cat)

# Single jq call: emit one value per line, in fixed order.
{
    IFS= read -r cwd
    IFS= read -r model
    IFS= read -r ctx_pct
    IFS= read -r cost
    IFS= read -r duration_ms
    IFS= read -r lines_added
    IFS= read -r lines_removed
    IFS= read -r exceeds_200k
} < <(printf '%s' "$input" | jq -r '
    (.workspace.current_dir // .cwd // ""),
    (.model.display_name // .model.id // ""),
    (.context_window.used_percentage // ""),
    (.cost.total_cost_usd // ""),
    (.cost.total_duration_ms // ""),
    (.cost.total_lines_added // ""),
    (.cost.total_lines_removed // ""),
    (.exceeds_200k_tokens // false)
')

# --- Helpers ----------------------------------------------------------------
fmt_tokens() { # 1234567 -> 1.2M ; 12345 -> 12K ; <1000 -> raw
    local n=$1
    if [ "$n" -ge 1000000 ] 2>/dev/null; then
        awk -v n="$n" 'BEGIN { printf "%.1fM", n/1000000 }'
    elif [ "$n" -ge 1000 ] 2>/dev/null; then
        awk -v n="$n" 'BEGIN { printf "%.1fK", n/1000 }'
    else
        printf '%s' "$n"
    fi
}

fmt_duration() { # ms -> 12s / 5m / 1h12m
    local ms=$1
    local s=$((ms / 1000))
    if [ "$s" -lt 60 ]; then
        printf '%ds' "$s"
    elif [ "$s" -lt 3600 ]; then
        printf '%dm' "$((s / 60))"
    else
        printf '%dh%dm' "$((s / 3600))" "$(((s % 3600) / 60))"
    fi
}

# --- Directory --------------------------------------------------------------
dir_display=""
if [ -n "$cwd" ]; then
    case "$cwd" in
        "$HOME") dir_display="~" ;;
        "$HOME"/*) dir_display="~${cwd#$HOME}" ;;
        *) dir_display="$cwd" ;;
    esac
fi

# --- Git --------------------------------------------------------------------
git_segment=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
        || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)

    dirty=""
    if ! git -C "$cwd" diff --quiet --ignore-submodules HEAD 2>/dev/null \
        || ! git -C "$cwd" diff --cached --quiet --ignore-submodules HEAD 2>/dev/null \
        || [ -n "$(git -C "$cwd" ls-files --others --exclude-standard 2>/dev/null)" ]; then
        dirty="*"
    fi

    ahead_behind=""
    if upstream=$(git -C "$cwd" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null); then
        counts=$(git -C "$cwd" rev-list --left-right --count "HEAD...$upstream" 2>/dev/null)
        ahead=${counts%%[[:space:]]*}
        behind=${counts##*[[:space:]]}
        [ "${ahead:-0}" -gt 0 ] 2>/dev/null && ahead_behind+="↑${ahead}"
        [ "${behind:-0}" -gt 0 ] 2>/dev/null && ahead_behind+="↓${behind}"
    else
        ahead_behind="?"
    fi

    branch_color="$GREEN"
    [ -n "$dirty" ] && branch_color="$YELLOW"
    git_segment="${branch_color}${branch}${dirty}${RESET}"
    [ -n "$ahead_behind" ] && git_segment+=" ${DIM}${ahead_behind}${RESET}"
fi

# --- Model ------------------------------------------------------------------
model_segment=""
if [ -n "$model" ]; then
    case "$model" in
        *Opus*|*opus*)     model_color="$MAGENTA" ;;
        *Sonnet*|*sonnet*) model_color="$BLUE" ;;
        *Haiku*|*haiku*)   model_color="$GREEN" ;;
        *)                 model_color="$CYAN" ;;
    esac
    model_segment="${model_color}${model}${RESET}"
fi

# --- Context ----------------------------------------------------------------
ctx_segment=""
if [ -n "$ctx_pct" ] && [ "$ctx_pct" != "null" ]; then
    pct_int=${ctx_pct%.*}
    if [ "$pct_int" -ge 80 ] 2>/dev/null; then
        ctx_color="$RED"
    elif [ "$pct_int" -ge 50 ] 2>/dev/null; then
        ctx_color="$YELLOW"
    else
        ctx_color="$GREEN"
    fi
    ctx_segment="${ctx_color}ctx ${pct_int}%${RESET}"
fi

# --- Cost -------------------------------------------------------------------
cost_segment=""
if [ -n "$cost" ] && [ "$cost" != "null" ]; then
    cost_segment=$(printf '%s$%.2f%s' "$DIM" "$cost" "$RESET")
fi

# --- Lines added/removed (this session) ------------------------------------
diff_segment=""
la=${lines_added:-0}; lr=${lines_removed:-0}
[ "$la" = "null" ] && la=0; [ "$lr" = "null" ] && lr=0
if [ "$la" -gt 0 ] 2>/dev/null || [ "$lr" -gt 0 ] 2>/dev/null; then
    diff_segment="${GREEN}+${la}${RESET} ${RED}-${lr}${RESET}"
fi

# --- 200k warning -----------------------------------------------------------
warn_segment=""
if [ "$exceeds_200k" = "true" ]; then
    warn_segment="${BOLD}${RED}!200k${RESET}"
fi

# --- Elapsed (session wall clock) ------------------------------------------
elapsed_segment=""
if [ -n "$duration_ms" ] && [ "$duration_ms" != "null" ] && [ "$duration_ms" -gt 0 ] 2>/dev/null; then
    elapsed_segment="${DIM}$(fmt_duration "$duration_ms")${RESET}"
fi

# --- Today's totals (sessions + tokens) ------------------------------------
today_segment=""
today=$(date +%Y-%m-%d)
projects_dir="${HOME}/.claude/projects"
if [ -d "$projects_dir" ]; then
    files=$(find "$projects_dir" -name '*.jsonl' -type f -newermt "$today 00:00" 2>/dev/null)
    if [ -n "$files" ]; then
        sess_count=$(printf '%s\n' "$files" | wc -l | tr -d ' ')
        total_tok=$(printf '%s\n' "$files" \
            | xargs jq -c 'select(.message.usage != null) | .message.usage | (.input_tokens + .output_tokens + (.cache_read_input_tokens // 0) + (.cache_creation_input_tokens // 0))' 2>/dev/null \
            | awk '{s+=$1} END {print s+0}')
        today_segment="${DIM}today $(fmt_tokens "${total_tok:-0}")/${sess_count}s${RESET}"
    fi
fi

# --- Compose ----------------------------------------------------------------
# Line 1: live state
line1=()
[ -n "$dir_display" ]   && line1+=("${BOLD}${BLUE}${dir_display}${RESET}")
[ -n "$git_segment" ]   && line1+=("$git_segment")
[ -n "$model_segment" ] && line1+=("$model_segment")
[ -n "$ctx_segment" ]   && line1+=("$ctx_segment")
[ -n "$warn_segment" ]  && line1+=("$warn_segment")
[ -n "$cost_segment" ]  && line1+=("$cost_segment")
[ -n "$diff_segment" ]  && line1+=("$diff_segment")

# Line 2: meta / accumulated (all dim)
line2=()
[ -n "$elapsed_segment" ] && line2+=("$elapsed_segment")
[ -n "$today_segment" ]   && line2+=("$today_segment")

join() { # $1 = sep ; rest = parts
    local sep=$1; shift
    local out="" i
    for i in "$@"; do
        [ -n "$out" ] && out+="$sep"
        out+="$i"
    done
    printf '%s' "$out"
}

out=""
if [ "${#line1[@]}" -gt 0 ]; then
    out=$(join "$SEP" "${line1[@]}")
fi
if [ "${#line2[@]}" -gt 0 ]; then
    [ -n "$out" ] && out+=$'\n'
    out+=$(join "$SEP2" "${line2[@]}")
fi

printf '%b' "$out"
