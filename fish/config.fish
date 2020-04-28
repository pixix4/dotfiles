set -g theme_display_date no

alias gst='git status'
alias sm='sm -i'
alias smc='sm -n mono'
alias ls='ls --color=auto'
alias sizeof='du -sh'
alias x='exa --header -l --git'
alias trackpoint="~/dotfiles/scripts/reconnect-trackpoint.sh"
alias vim="nvim"

set -U theme_color_scheme terminal

source ~/.bintray.fish
source ~/.cargo/bin/asciii.fish

set -gx PATH ~/.cargo/bin $PATH

set -gx TERM "xterm-256color"
set -gx EDITOR "nvim"

eval (starship init fish)

if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec sway
    end
end

