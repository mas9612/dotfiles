# set path
path=(/usr/local/opt/openssl@1.1/bin(N-/) /usr/local/bin(N-/) /usr/local/git/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin/run(N-/) /Library/TeX/texbin(N-/) ${path})
fpath=(/usr/local/share/zsh-completions(N-/) ~/.zsh/completions(N-/) $fpath)

# golang
path=($HOME/go/bin(N-/) ${path})
export GOPATH=$HOME/go

# for Docker Engine API
export DOCKER_API_VERSION=`docker version | awk '/API version/ {print $3}' | head -1`

# latex style file
export TEXINPUTS=.:~/github/tex_gaiyo/:

export PYTHONPATH=/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/bin:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python37.zip:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7/lib-dynload:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7/site-packages:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7/site-packages/IPython/extensions:$PYTHONPATH

export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
