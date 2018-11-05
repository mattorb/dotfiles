function fcop -d "Git checkout w/preview"

  git tag | \
    awk '{print "\x1b[31;1mtag\x1b[m\t" $1}' | \
    read -z tags
  
  git branch --all | \
    grep -v HEAD | sed "s/.* //" | sed "s#remotes/[^/]*/##" | \
    sort -u | \
    awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}' | \
    read -z branches

  set target (printf '%s%s' $tags $branches | \
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
        --ansi --preview="git log -200 --pretty=format:%s (echo {+2..} | sed 's/\$/../' )" )
  
  git checkout (echo "$target" | awk '{print $2}')
end

