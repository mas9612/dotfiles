#!/bin/bash

set -eux
set -o pipefail

script_dir=$(cd $(dirname $0); pwd)

ln -sfh ${script_dir}/.vimrc ~/.vimrc
ln -sfh ${script_dir}/.zshrc ~/.zshrc
ln -sfh ${script_dir}/.vim ~/.vim

if [ -f ${script_dir}/.zshrc_work ]; then
  ln -s ${script_dir}/.zshrc_work ~/.zshrc_work
fi

if [ "$(uname -s)" = "Darwin" ]; then
  brew bundle
fi
