#!/bin/bash

ln -sf $PWD/zshenv ~/.zshenv
ln -sf $PWD/zshrc ~/.zshrc
ln -sf $PWD/tmux.conf ~/.tmux.conf

ln -sf $PWD/ctags ~/.ctags
ln -sf $PWD/latexmkrc ~/.latexmkrc

if [ ! -d ~/.vim ]; then
    mkdir -p ~/.vim
fi
ln -sf $PWD/vim/vimrc ~/.vimrc
ln -sf $PWD/vim/gvimrc ~/.gvimrc
ln -sf $PWD/vim/colors ~/.vim/colors
ln -sf $PWD/vim/ftplugin ~/.vim/ftplugin
ln -sf $PWD/vim/template ~/.vim/template
ln -sf $PWD/vim/snippets ~/.vim/snippets

if [ `which pip` ]; then
    pip install -r $PWD/pip_requirements.txt
fi

# install vim plugins
vim -c ':PlugInstall | :wqa'
