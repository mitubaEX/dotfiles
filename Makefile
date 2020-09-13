install:
	sh ./install.sh

setup:
	sh ./setup.sh

update:
	sh ./update.sh

reset:
	sh ./reset.sh

deno_completion:
	deno completions zsh > $HOME/.config/deno_completions.zsh

update_vscode_data:
	rm script/vscode_data.txt && code --list-extensions > script/vscode_data.txt
