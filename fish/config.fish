set -xg PATH $HOME/bin $PATH
set -xg EDITOR (which code) -w

function fish_user_key_bindings
    set -U FZF_LEGACY_KEYBINDINGS 0
    source $HOME/.config/fish/conf.d/fzf_key_bindings.fish
    source $HOME/.config/fish/functions/keys_bindings.fish
end

set -x FZF_COMPLETE 1
set -x FZF_REVERSE_ISEARCH_OPTS '--preview-window=up:10 --preview="echo {}" --height 100%'

# locals.fish is a home for anything machine specific
if test -e ~/.config/fish/locals.fish
    source ~/.config/fish/locals.fish
end

alias l 'exa -l -g --git'

# Shows all timestamps in their full glory
alias lf 'exa -guUmhl --git --time-style long-iso'