#!/bin/bash

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
ln -sf $PWD/.tmux.conf ~/.tmux.conf

ln -sf $PWD/.ctags ~/.ctags

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.vim ~/.vim

echo "compiling Vim..."
git clone https://github.com/vim/vim.git
prev_dir=`pwd`
cd vim
./configure --prefix=/opt --enable-fail-if-missing --enable-luainterp=yes --enable-python3interp=yes --with-lua-prefix=/usr/local   &&  \
    make && sudo make install
# for now, stripped binary won't work properly. So copy unstrupped binary to bin directory
sudo cp src/vim /opt/bin/vim
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
