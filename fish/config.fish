set -g theme_display_date no

alias pof='poweroff'
alias gst='git status'
alias sm='sm -i'
alias smc='sm -n mono'
alias rs='setsid redshift'
alias reload-color='killall -USR1 termite'
alias ccat='pygmentize -g'
alias ccd='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias ls='ls --color=auto'
alias fuck='eval sudo \$history[1]'
alias update='yes \n | yay -Syyu'
alias sizeof='du -sh'
alias x='exa --header -l'
alias mines="/daten/PMines/main.py"
alias trackpoint="~/dotfiles/scripts/reconnect-trackpoint.sh"

set -U theme_color_scheme terminal

function reverse_history_search
  history | fzf --no-sort | read -l command
  if test $command
    commandline -rb $command
  end
end

function fish_user_key_bindings
  bind \cr reverse_history_search
end

