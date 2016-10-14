# set path
path=(/usr/local/bin(N-/) /usr/local/git/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin/run(N-/) ${path})
fpath=(/usr/local/share/zsh-completions $fpath)

# pyenv
# export PYENV_ROOT=/usr/local/var/pyenv
# if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# pyenv-virtualenv
# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# set Java encoding to utf-8
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
