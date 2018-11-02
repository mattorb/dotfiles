function fco -d "Checkout local git branch, sorted by recent"
  git branch -vv | read -z branches; 
  set branch (echo "$branches" | fzf +m) ;
  git checkout (echo "$branch" | awk '{print $1}' | sed "s/.* //")
end
