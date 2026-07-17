#!/bin/sh
# usage: copy_worktree_include <branch> <repo_root>
#   <branch>    ローカルブランチ名 (git worktree list --porcelain の branch 行にマッチさせる)
#   <repo_root> リポジトリのトップレベル (.worktreeinclude を探す起点)
#
# 新しく作られた worktree に .worktreeinclude で指定された git 管理外ファイルをコピーする。
# .worktreeinclude は 1 行 1 パターン、空行と # 始まりはコメント。glob 可。
copy_worktree_include() {
  branch=$1
  repo_root=$2

  include_file="$repo_root/.worktreeinclude"
  [ -f "$include_file" ] || return 0

  worktree_path=$(git worktree list --porcelain | awk -v ref="refs/heads/$branch" '
    /^worktree / { wt = substr($0, 10) }
    $0 == "branch " ref { print wt; exit }
  ')
  if [ -z "$worktree_path" ]; then
    echo "warn: worktree のパスを特定できないため .worktreeinclude のコピーをスキップします" >&2
    return 0
  fi

  while IFS= read -r pattern || [ -n "$pattern" ]; do
    case "$pattern" in ""|\#*) continue ;; esac
    (
      cd "$repo_root" || exit 0
      for src in $pattern; do
        [ -e "$src" ] || continue
        dest="$worktree_path/$src"
        mkdir -p "$(dirname "$dest")"
        # cp -R はコピー先に同名ディレクトリがあると入れ子になるため先に消す
        [ -d "$dest" ] && rm -rf "$dest"
        cp -R "$src" "$dest"
        echo "copied: $src"
      done
    )
  done < "$include_file"
}
