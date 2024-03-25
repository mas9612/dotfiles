#!/bin/sh

set -eux
set -o pipefail

ln -sfh $(pwd)/.vimrc ~/.vimrc
ln -sfh $(pwd)/.zshrc ~/.zshrc
ln -sfh $(pwd)/.vim ~/.vim

if [ ! -f ~/.zshrc_work ]; then
  ln -s $(pwd)/.zshrc_work ~/.zshrc_work
fi

if [ "$(uname -s)" = "Darwin" ]; then
  brew bundle
fi