# set path
path=(/usr/local/bin(N-/) /usr/local/git/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin/run(N-/) ${path})
fpath=(/usr/local/share/zsh-completions $fpath)

# golang
path=($HOME/.golang/bin(N-/) ${path})
export GOPATH=$HOME/.golang

# boost path settings
export BOOST_ROOT=(/usr/local/Cellar/boost/1.62.0)

# set Java encoding to utf-8
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
