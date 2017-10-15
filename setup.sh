#!/bin/bash

PWD=`pwd`

ln -s $PWD/zshenv ~/.zshenv
ln -s $PWD/zshrc ~/.zshrc
ln -s $PWD/tmux.conf ~/.tmux.conf

ln -s $PWD/ctags ~/.ctags
ln -s $PWD/latexmkrc ~/.latexmkrc

if [ ! -d ~/.vim ]; then
    mkdir -f ~/.vim
fi
ln -s $PWD/vim/vimrc ~/.vimrc
ln -s $PWD/vim/gvimrc ~/.gvimrc
ln -s $PWD/vim/colors ~/.vim/colors
ln -s $PWD/vim/ftplugin ~/.vim/ftplugin
ln -s $PWD/vim/template ~/.vim/template
ln -s $PWD/vim/snippets ~/.vim/snippets

if [ `which pip` ]; then
    pip install -r $PWD/pip_requirements.txt
fi
