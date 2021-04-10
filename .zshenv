# set path
path=(/opt/bin(N-/) /usr/local/opt/openssl@1.1/bin(N-/) /usr/local/bin(N-/) /usr/local/git/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin/run(N-/) ${path})
fpath=(~/.zsh_autoload_funcs(N-/) /usr/local/share/zsh-completions(N-/) ~/.zsh/completions(N-/) $fpath)

# golang
path=(${path} $HOME/go/bin(N-/))
export GOPATH=$HOME/go

export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
