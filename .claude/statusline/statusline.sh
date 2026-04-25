#!/usr/bin/env bash
# Claude Code statusline (minimal, no font dependency)
# Reads JSON from stdin and prints a single-line status to stdout.

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

# --- Read input -------------------------------------------------------------
input=$(cat)

cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(printf '%s' "$input" | jq -r '.model.display_name // .model.id // empty')
ctx_pct=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(printf '%s' "$input" | jq -r '.cost.total_cost_usd // empty')

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

    # dirty?
    dirty=""
    if ! git -C "$cwd" diff --quiet --ignore-submodules HEAD 2>/dev/null \
        || ! git -C "$cwd" diff --cached --quiet --ignore-submodules HEAD 2>/dev/null \
        || [ -n "$(git -C "$cwd" ls-files --others --exclude-standard 2>/dev/null)" ]; then
        dirty="*"
    fi

    # ahead/behind upstream
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

# --- Compose ----------------------------------------------------------------
parts=()
[ -n "$dir_display" ]   && parts+=("${BOLD}${BLUE}${dir_display}${RESET}")
[ -n "$git_segment" ]   && parts+=("$git_segment")
[ -n "$model_segment" ] && parts+=("$model_segment")
[ -n "$ctx_segment" ]   && parts+=("$ctx_segment")
[ -n "$cost_segment" ]  && parts+=("$cost_segment")

out=""
for i in "${!parts[@]}"; do
    [ "$i" -gt 0 ] && out+="$SEP"
    out+="${parts[$i]}"
done

printf '%b' "$out"
