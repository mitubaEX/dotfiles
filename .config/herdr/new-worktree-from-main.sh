#!/bin/sh
# herdr の keys.command (type = "pane") から呼ばれる想定。
# 最新の origin/<default-branch> を fetch してから herdr worktree を作成する。
# pane はコマンド終了と同時に閉じるため、エラー時は read で止めてメッセージを読めるようにする。

fail() {
  echo "error: $1" >&2
  printf "Enter で閉じる..." >&2
  read -r _
  exit 1
}

# symlink 経由 (~/.local/bin 等) でも実体の隣の lib/ を参照できるよう実パスを解決する
script_dir=$(dirname "$(readlink -f "$0")")
. "$script_dir/lib/copy-worktree-include.sh" || fail "lib/copy-worktree-include.sh を読み込めません"

git rev-parse --git-dir >/dev/null 2>&1 || fail "git リポジトリ内で実行してください (cwd: $(pwd))"

default_branch=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|^origin/||')
if [ -z "$default_branch" ]; then
  if git show-ref --verify --quiet refs/remotes/origin/main; then
    default_branch=main
  elif git show-ref --verify --quiet refs/remotes/origin/master; then
    default_branch=master
  else
    fail "origin のデフォルトブランチを特定できません"
  fi
fi

printf "base: origin/%s (最新を fetch します)\n" "$default_branch"
printf "branch 名 (mitubaEX/ は自動付与、空 Enter で中止): "
read -r name
[ -n "$name" ] || exit 0

case "$name" in
  mitubaEX/*) branch=$name ;;
  *) branch="mitubaEX/$name" ;;
esac

echo "git fetch origin $default_branch ..."
git fetch origin "$default_branch" || fail "git fetch に失敗しました"

repo_root=$(git rev-parse --show-toplevel) || fail "リポジトリのルートを特定できません"

herdr worktree create --branch "$branch" --base "origin/$default_branch" --focus \
  || fail "herdr worktree create に失敗しました"

copy_worktree_include "$branch" "$repo_root"
