#!/bin/sh
# herdr の keys.command (type = "pane") から呼ばれる想定。
# PR 番号または URL を対話入力して、その PR head branch の worktree を作成する。
# fork からの PR にも対応するため git fetch origin pull/<N>/head を使う。
# 作成される local branch 名は pr/<N> 固定。worktree ディレクトリは
# ~/.herdr/worktrees/pr/<N> の形で herdr が配置する。

fail() {
  echo "error: $1" >&2
  printf "Enter で閉じる..." >&2
  read -r _
  exit 1
}

# symlink 経由 (~/.local/bin 等) でも実体の隣の lib/ を参照できるよう実パスを解決する
script_dir=$(dirname "$(readlink -f "$0")")
. "$script_dir/lib/copy-worktree-include.sh" || fail "lib/copy-worktree-include.sh を読み込めません"

# gh は ~/bin/gh を利用する (ghtkn 経由で GH_TOKEN を注入するラッパー)。
# 必要なら shell 側で GHTKN_APP を export しておくこと (例: `export GHTKN_APP=...`)。
GH_BIN="$HOME/bin/gh"

git rev-parse --git-dir >/dev/null 2>&1 || fail "git リポジトリ内で実行してください (cwd: $(pwd))"
[ -x "$GH_BIN" ] || fail "$GH_BIN が見つからない or 実行可能でありません"

printf "PR 番号 or URL (空 Enter で中止): "
read -r input
[ -n "$input" ] || exit 0

# URL / #N / N のいずれからも PR 番号を抽出。
pr_num=$(printf '%s' "$input" | sed -E 's|.*/pull/([0-9]+).*|\1|; s|^#||')
case "$pr_num" in
  ''|*[!0-9]*) fail "PR 番号を特定できません: $input" ;;
esac

echo "gh pr view $pr_num ..."
pr_info=$("$GH_BIN" pr view "$pr_num" --json number,headRefName,title,isCrossRepository 2>&1) \
  || fail "gh pr view に失敗しました: $pr_info"

head_ref=$(printf '%s' "$pr_info" | sed -n 's/.*"headRefName":"\([^"]*\)".*/\1/p')
title=$(printf '%s' "$pr_info" | sed -n 's/.*"title":"\([^"]*\)".*/\1/p')

printf "PR #%s: %s\n" "$pr_num" "$title"
printf "head branch: %s\n" "$head_ref"

branch="pr/$pr_num"

# 既に worktree があると herdr worktree create が失敗するので、事前に案内して削除するか確認。
existing=$(git worktree list --porcelain | awk -v ref="refs/heads/$branch" '
  /^worktree / { wt = substr($0, 10) }
  $0 == "branch " ref { print wt; exit }
')
if [ -n "$existing" ]; then
  printf "既存 worktree あり: %s\n" "$existing"
  printf "削除して作り直す? [y/N]: "
  read -r ans
  case "$ans" in
    y|Y|yes|YES)
      # herdr 側にも登録されているのでまず herdr で消す (git worktree remove へ委譲される)。
      herdr worktree remove "$existing" 2>/dev/null \
        || git worktree remove --force "$existing" \
        || fail "既存 worktree の削除に失敗しました: $existing"
      # ローカルブランチも消して pr/<N> を fetch し直せるようにする。
      git branch -D "$branch" 2>/dev/null || true
      ;;
    *) exit 0 ;;
  esac
fi

# +refspec で force update: PR が rebase / force push された時に追従できる。
echo "git fetch origin pull/$pr_num/head:$branch ..."
git fetch origin "+refs/pull/$pr_num/head:refs/heads/$branch" \
  || fail "git fetch に失敗しました (PR $pr_num が非公開 or 削除済み?)"

repo_root=$(git rev-parse --show-toplevel) || fail "リポジトリのルートを特定できません"

herdr worktree create --branch "$branch" --focus \
  || fail "herdr worktree create に失敗しました"

copy_worktree_include "$branch" "$repo_root"

printf "PR #%s (%s) の worktree を作成しました\n" "$pr_num" "$head_ref"
