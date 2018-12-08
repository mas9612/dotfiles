# set path
path=(/usr/local/opt/openssl@1.1/bin(N-/) /usr/local/bin(N-/) /usr/local/git/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin/run(N-/) ${path})
fpath=(/usr/local/share/zsh-completions(N-/) ~/.zsh/completions(N-/) $fpath)

# golang
path=($HOME/.golang/bin(N-/) ${path})
export GOPATH=$HOME/go

# boost path settings
export BOOST_ROOT=(/usr/local/Cellar/boost/1.62.0)

# set Java encoding to utf-8
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

# for Docker Engine API
export DOCKER_API_VERSION=`docker version | awk '/API version/ {print $3}' | head -1`

# latex style file
export TEXINPUTS=.:~/github/tex_gaiyo/:

export PYTHONPATH=/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/bin:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python37.zip:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7/lib-dynload:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7/site-packages:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7/site-packages/IPython/extensions:$PYTHONPATH

export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
