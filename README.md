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

statusline 本体は外部リポジトリ ([kama-meshi/cc-my-statusline](https://github.com/kama-meshi/cc-my-statusline)) を `~/.claude/statusline` にクローンして利用する。

```sh
git clone git@github.com:kama-meshi/cc-my-statusline.git $HOME/.claude/statusline
```

`~/.claude/settings.json` に `.claude/settings.statusline.json` の内容を取り込む (env など他の設定とマージする想定)。
