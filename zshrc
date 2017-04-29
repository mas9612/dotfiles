# Don't register duplicated path
typeset -U path cdpath fpath manpath

# set path for sudo
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))

# pyenv
export PYENV_ROOT=/usr/local/var/pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# for zsh-completions
autoload -Uz compinit
compinit -u

# search history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

export EDITOR=vim           # set editor to vim
export LANG=ja_JP.UTF-8     # set char code to utf-8
bindkey -e                  # set keybind to emacs-mode

HISTFILE=~/.zsh_history     # file saved history
HISTSIZE=10000              # number of history saved to memory
SAVEHIST=10000              # saved history amount
setopt hist_ignore_dups     # don't save duplicated history
setopt share_history
setopt auto_cd

alias ...='cd ../..'
alias ....='cd ../../..'
alias l='ls'
alias ll='ls -l'
alias la='ls -la'

alias sed='gsed'

alias ts='tmux ls'
alias ta='tmux attach -t'

alias wifirestart='networksetup -setairportpower en0 off;networksetup -setairportpower en0 on'
alias wifioff='networksetup -setairportpower en0 off'
alias wifion='networksetup -setairportpower en0 on'

autoload -U colors; colors  # coloring prompt
# user
tmp_prompt="%F{cyan}[%n@%D{%m/%d %T}]%f "
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"
# root (font-weight: bold, added under score)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;
