if test -e /opt/homebrew/bin/brew 
    eval $(/opt/homebrew/bin/brew shellenv)
end

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

# glow for markdown files, override cat muscle memory :)
function cat
    if string match -q '*.md' -- $argv[1]
        glow -p -w (math (tput cols) - 5) $argv
    else
        command cat $argv
    end
end

function glow
    command glow -p -w (math (tput cols) - 5) $argv
end

# eza replace exa
alias l 'eza -l -g --git'

# Shows all timestamps in their full glory
alias lf 'eza -guUmhl --git --time-style long-iso'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/msmith/anaconda3/bin/conda
    eval /Users/msmith/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

