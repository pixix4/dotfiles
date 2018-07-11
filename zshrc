# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle ':completion:*' rehash true
alias pof='poweroff'
alias reload='source ~/.zshrc'
alias remove-orphanage='sudo pacman -Rsn $(pacman -Qdtq)'
alias gst='git status'
alias sm='sm -i'
alias smc='sm -n mono'
alias stop-docker='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias reload-color='killall -USR1 termite'

