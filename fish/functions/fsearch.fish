function fsearch -d "Fuzzy search w/grep"
    grep --line-buffered --color=never -r "" * | fzf
end
