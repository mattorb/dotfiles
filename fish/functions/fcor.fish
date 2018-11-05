function fcor -d "Checkout git branch (including remotes)"
  git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)" | read -z branches; 
  set branch (printf '%s' $branches | fzf-tmux -d (math 2 + (echo "$branches" | wc -l)) +m)
  git checkout (echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
end
