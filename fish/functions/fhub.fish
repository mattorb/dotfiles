# Offers an fzf chooser to pop open a repo's github home page in the browser
function fhub -d 'Choose a repo to open github homepage for.  Put personal access token in $HOME/.fhub_token and additional orgs in $HOME/.fhub_orgs'
    if not test -e "$HOME/.fhub_token"
        echo "Put github personal access token in $HOME/.fhub_token"
        return 1
    end
    
    if test -e "$HOME/.fhub_token"
        read -z ADD_ORGS < $HOME/.fhub_orgs
    end 

    listrepo (cat $HOME/.fhub_token) $ADD_ORGS | fzf | read -l repo

    if test -n "$repo"
        echo "Opening '$repo' in Github"
        hub browse $repo
    end
end