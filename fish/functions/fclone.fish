# Offers an fzf chooser to clone a github repo
function fclone -d 'Choose a repo to to clone.  Put personal access token in $HOME/.fhub_token and additional orgs in $HOME/.fhub_orgs'
    if not test -e "$HOME/.fhub_token"
        echo "Put github personal access token in $HOME/.fhub_token"
        return 1
    end
    
    if test -e "$HOME/.fhub_token"
        read -z ADD_ORGS < $HOME/.fhub_orgs
    end 

    listrepo (cat $HOME/.fhub_token) $ADD_ORGS | fzf | read -l repo

    if test -n "$repo"
        echo "Cloning '$repo' from Github"
        git clone "https://github.com/$repo.git"
    end
end