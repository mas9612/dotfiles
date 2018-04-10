# set path
path=(/usr/local/bin(N-/) /usr/local/git/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin/run(N-/) ${path})
fpath=(/usr/local/share/zsh-completions(N-/) ~/.zsh/completions(N-/) $fpath)

# golang
path=($HOME/.golang/bin(N-/) ${path})
export GOPATH=$HOME/.golang

# boost path settings
export BOOST_ROOT=(/usr/local/Cellar/boost/1.62.0)

# set Java encoding to utf-8
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

# for Docker Engine API
export DOCKER_API_VERSION=`docker version | awk '/API version/ {print $3}' | head -1`
