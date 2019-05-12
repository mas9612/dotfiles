# set path
path=(/usr/local/opt/openssl@1.1/bin(N-/) /usr/local/bin(N-/) /usr/local/git/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin/run(N-/) /Library/TeX/texbin(N-/) ${path})
fpath=(/usr/local/share/zsh-completions(N-/) ~/.zsh/completions(N-/) $fpath)

# golang
path=($HOME/go/bin(N-/) ${path})
export GOPATH=$HOME/go

export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
