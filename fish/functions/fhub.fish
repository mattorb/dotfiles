function fhub -d 'Open github homepage for repo. list user/orgs in $HOME/.fhub_user_orgs'
    if not test -e "$HOME/.fhub_user_orgs"
        echo "Put users/xxx or orgs/yyy lines in $HOME/.fhub_user_orgs to specify which to include in search"
        return 1
    end

    read -z USER_ORGS < $HOME/.fhub_user_orgs

    if test "$status" != "0"
        echo "Put users/xxx or orgs/yyy lines in $HOME/.fhub_user_orgs to specify which to include in search"
        return 2
    end

    mkfifo t

    echo $USER_ORGS | \
        xargs -L1 -I'{}' \
        curl 'https://api.github.com/''{}''/repos?per_page=100&page=1' 2>/dev/null \
            | jq --stream -r 'select(.[0][1] == "full_name") | .[1]' > t &
    
    cat t | fzf | read -l repo

    if test -n "$repo"
        echo "Opening '$repo' in Github"
        hub browse $repo
    end
end
