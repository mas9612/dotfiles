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
    ${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin
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

autoload -Uz colors
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' branchformat "%b"
zstyle ':vcs_info:git:*' stagedstr "%F{green}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

precmd() {
    vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}

PROMPT="%F{cyan}[%n:%~]%f "
PROMPT2="%F{cyan}%_>%f "

export FZF_DEFAULT_COMMAND='ag --hidden --skip-vcs-ignores --ignore .git --ignore __pycache__ -l -g ""'
export FZF_DEFAULT_OPTS='--height 30% --border --reverse'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

source ${HOME}/.zshrc_work
