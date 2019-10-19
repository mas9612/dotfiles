# Don't register duplicated path
typeset -U path cdpath fpath manpath

# set path for sudo
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))

# pyenv
export PYENV_ROOT=/usr/local/var/pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

export EDITOR=vim           # set editor to vim
export LANG=en_US.UTF-8     # set char code to utf-8
bindkey -e                  # set keybind to emacs-mode

# latex style file, bibliography file
export TEXINPUTS=.:~/github/tex_styles/:~/Dropbox/mendeley/bibliography/:

export PYTHONPATH=/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/bin:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python37.zip:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7/lib-dynload:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7/site-packages:/usr/local/var/pyenv/versions/${CURRENT_PYTHON_VERSION}/lib/python3.7/site-packages/IPython/extensions:$PYTHONPATH

HISTFILE=~/.zsh_history     # file saved history
HISTSIZE=10000              # number of history saved to memory
SAVEHIST=10000              # saved history amount


# enable zsh-completions
autoload -Uz compinit
compinit -u

# search history
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


setopt auto_cd
setopt auto_list
setopt hist_ignore_all_dups
setopt share_history
setopt ignore_eof
setopt prompt_subst


alias ...='cd ../..'
alias ....='cd ../../..'
alias l='ls'
alias ll='ls -l'
alias la='ls -la'

alias grep='grep --color=auto'

alias sed='gsed'

alias ts='tmux ls'
alias ta='tmux attach -t'

alias wifirestart='networksetup -setairportpower en0 off;networksetup -setairportpower en0 on'
alias wifioff='networksetup -setairportpower en0 off'
alias wifion='networksetup -setairportpower en0 on'

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
    export CURRENT_PYTHON_VERSION="$(cat $(pyenv root)/version)"
}

PROMPT="%F{cyan}[%n:%~]%f "
PROMPT2="%F{cyan}%_>%f "

# enable kubectl autocomplete
source <(kubectl completion zsh)

# convert Markdown to PDF with pandoc
md2pdf () {
    input=$1
    output="`echo $input | rev | cut -f2- -d. | rev`.pdf"

    pandoc --pdf-engine=lualatex    \
        -V documentclass=ltjarticle \
        -V geometry:a4paper         \
        -V geometry:top=3.5cm       \
        -V geometry:left=3cm        \
        -V geometry:right=3cm       \
        -V geometry:bottom=3cm      \
        --listings                  \
        -f markdown -t latex        \
        -o $output                  \
        $input
}


##################################################
# fzf config
##################################################
export FZF_DEFAULT_COMMAND='ag --hidden --skip-vcs-ignores --ignore .git --ignore __pycache__ -l -g ""'
export FZF_DEFAULT_OPTS='--height 30% --border --reverse'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
