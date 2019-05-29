# Offers an fzf chooser to clone a github repo
function fclone -d 'Choose a repo to to clone.  Put personal access token in $HOME/.fhub_token and additional orgs in $HOME/.fhub_orgs'
    fgithubrepo clonegithubrepo
end

function clonegithubrepo
    set REPO "$argv[1]"
    echo "Cloning '$REPO' from Github"
    git clone git@github.com:$REPO.git
end