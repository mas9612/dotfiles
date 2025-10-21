# For arrays, keep only the first occurrence of each duplicated value
typeset -U PATH path FPATH fpath

# set path for sudo
typeset -xT SUDO_PATH sudo_path
typeset -U SUDO_PATH sudo_path
# N-/: Add only existed path, follow symlink, add only directory
# ref.
# - zshexpn(1) - Glob Qualifiers
# - zshparam(1) - Expansion and Globbing
sudo_path=({/usr/local,/usr,}/sbin(N-/))

path=(
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    ${HOME}/go/bin(N-/)
    ${path}
)

if type brew &>/dev/null; then
    fpath=($(brew --prefix)/share/zsh-completions(N-/) ${fpath})
    autoload -Uz compinit
    compinit
fi

export EDITOR=vim
export LANG=en_US.UTF-8
# set keybind to emacs-mode
bindkey -e

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt auto_cd
setopt auto_list
setopt hist_ignore_all_dups
setopt share_history
setopt ignore_eof
setopt prompt_subst

alias l='ls -G'
alias ll='ls -lG'
alias la='ls -laG'
alias grep='ggrep --color=auto'
alias sed='gsed'

export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"

autoload -Uz colors
colors

PROMPT="%F{cyan}[%n:%~]%f "
PROMPT2="%F{cyan}%_>%f "

export FZF_DEFAULT_COMMAND='ag --hidden --skip-vcs-ignores --ignore .git --ignore __pycache__ -l -g ""'
export FZF_DEFAULT_OPTS='--height 30% --border --reverse'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function ghqlist() {
    project=$(ghq list | fzf)
    if [ -n "${project}" ]; then
        code $(ghq root)/${project}
    fi
}

source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

source <(kubectl completion zsh)

[ -f ~/.zshrc_work ] && source ~/.zshrc_work

