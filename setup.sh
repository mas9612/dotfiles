#!/bin/bash

set -eux
set -o pipefail

script_dir=$(cd $(dirname $0); pwd)

ln -sfh ${script_dir}/.vimrc ~/.vimrc
ln -sfh ${script_dir}/.zshrc ~/.zshrc
ln -sfh ${script_dir}/.vim ~/.vim

if [ -f ${script_dir}/.zshrc_work ]; then
  ln -sfh ${script_dir}/.zshrc_work ~/.zshrc_work
fi

if [ "$(uname -s)" = "Darwin" ]; then
  brew bundle
  # for the second time and beyond
  brew upgrade
  brew cleanup
  brew bundle cleanup -f
fi

ln -sfh ${script_dir}/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sfh ${script_dir}/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

if [ -z "$(which code)" ]; then
  echo "[ERROR] Visual Studio Code is not installed." >&2
  exit 1
else
  for extension in $(cat ${script_dir}/vscode/extensions.txt); do
    code --install-extension ${extension}
  done
  code --update-extensions
fi
