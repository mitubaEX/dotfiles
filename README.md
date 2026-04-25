# dotfiles

## other dotfiles

- [zsh](https://github.com/mitubaEX/zsh_conf)
- [Neovim](https://github.com/mitubaEX/nvim_lua_config)

## use symbolic link

```sh
ln -sf $(pwd)/.config/wezterm/wezterm.lua $HOME/.config/wezterm/wezterm.lua
ln -sf $(pwd)/.config/aerospace/aerospace.toml $HOME/.config/aerospace/aerospace.toml
mkdir -p $HOME/.config/cmux
ln -sf $(pwd)/.config/cmux/settings.json $HOME/.config/cmux/settings.json
```

## Claude Code statusline

`.claude/statusline/statusline.sh` を `~/.claude/statusline/` に symlink して利用する。Nerd Font 等の依存はなし。

```sh
mkdir -p $HOME/.claude/statusline
ln -sfn $(pwd)/.claude/statusline/statusline.sh $HOME/.claude/statusline/statusline.sh
```

`~/.claude/settings.json` に `.claude/settings.statusline.json` の内容を取り込む (env など他の設定とマージする想定)。
