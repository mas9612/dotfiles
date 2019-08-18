#!/bin/bash

timedatectl set-timezone Asia/Tokyo

apt-get -y update && apt-get -y upgrade
apt-get -y install open-vm-tools-desktop realtek-rtl88xxau-dkms
shutdown -r now

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

ln -sf $PWD/.tmux.conf ~/.tmux.conf

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.vim ~/.vim

vim -c ':PlugInstall | :qa'
