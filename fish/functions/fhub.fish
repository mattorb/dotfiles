# Offers an fzf chooser to pop open a repo's github home page in the browser
function fhub -d 'Choose a repo to open github homepage for.  Put personal access token in $HOME/.fhub_token and additional orgs in $HOME/.fhub_orgs'
    fgithubrepo browsegithubrepo
end

function browsegithubrepo
    set REPO "$argv[1]"
    echo Opening $REPO in browser
    hub browse $REPO
end