# prezto
cd $HOME
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# powerline fonts
# clone
cd $HOME
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
