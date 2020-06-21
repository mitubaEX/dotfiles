install:
	sh ./install.sh

setup:
	sh ./setup.sh

update:
	sh ./update.sh

deno_completion:
	deno completions zsh > $HOME/.config/deno_completions.zsh
