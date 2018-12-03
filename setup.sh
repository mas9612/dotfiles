#!/bin/bash

cd `dirname $0`

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle
brew cleanup && brew bundle cleanup

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

ln -sf $PWD/.zshenv ~/.zshenv
ln -sf $PWD/.zshrc ~/.zshrc
ln -sf $PWD/.tmux.conf ~/.tmux.conf

ln -sf $PWD/.ctags ~/.ctags
ln -sf $PWD/.latexmkrc ~/.latexmkrc

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.gvimrc ~/.gvimrc
ln -sf $PWD/.vim ~/.vim

# install vim plugins
vim -c ':PlugInstall | :qa'
