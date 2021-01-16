#!/bin/bash

set -eu
set -o pipefail

cd `dirname $0`

os=`uname -s`

if [ "${os}" = "Darwin" ]; then
    echo "Checking whether Homebrew is installed..."
    which brew
    if [ $? = 0 ]; then
        echo "Homebrew is already installed."
    else
        echo "It seems Homebrew is not installed."
        echo "Installing homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    echo "Installing softwares..."
    brew bundle
    brew cleanup
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Linking config files..."
ln -sf $PWD/.zshenv ~/.zshenv
ln -sf $PWD/.zshrc ~/.zshrc
rm -f ~/.zsh_autoload_funcs && ln -sf $PWD/.zsh_autoload_funcs ~/.zsh_autoload_funcs
ln -sf $PWD/.tmux.conf ~/.tmux.conf

ln -sf $PWD/.ctags ~/.ctags

ln -sf $PWD/.vimrc ~/.vimrc
rm -f ~/.vim && ln -sf $PWD/.vim ~/.vim

echo "compiling Vim..."
if [ ! -d "$HOME/vim" ]; then
    git clone https://github.com/vim/vim.git $HOME/vim
fi
prev_dir=`pwd`
cd ~/vim
git checkout master && git pull origin master
latest_tag=$(git tag -l | tail -1)
vim_major_version=$(vim --version | awk '/VIM - Vi IMproved/ {print $5}')
vim_patch_version=$(vim --version | awk '/Included patches/ {print $3}' | cut -d'-' -f2)
installed_vim_version=${major_version}.${patch_version}

if [ "${installed_vim_version}" != "${latest_tag}" ]; then
    echo "Vim version ${latest_tag} will be installed."
    git checkout ${latest_tag}

    if [ "${os}" = "Darwin" ]; then
        ./configure --prefix=/opt --enable-fail-if-missing --enable-luainterp=yes --enable-python3interp=yes --with-lua-prefix=/usr/local   \
            --enable-multibyte  &&  \
            make && sudo make install
    else
        ./configure --prefix=/opt --enable-fail-if-missing --enable-luainterp=yes --enable-python3interp=yes --enable-multibyte &&  \
            make && sudo make install
    fi
fi
cd ${prev_dir}

echo "Installing Vim plugins..."
vim -c ':PlugInstall | :qa'

pip install -r ./pip_requirements.txt

if [ "${os}" = "Darwin" ]; then
    curl -LO https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Hybrid.itermcolors
    echo "iTerm2 color scheme \"Hybrid\" has been downloaded."
    echo "If you want to use it, load and enable it on iTerm2."
    echo "Path:" $PWD/Hybrid.itermcolors
fi

echo "Completed!"
