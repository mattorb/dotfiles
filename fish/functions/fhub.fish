# Given a list of github users and orgs in $HOME/.fhub_user_orgs, offers an fzf chooser to pop open a 
#  repo's github home page in the browser
#
# Does the right things to stream results from curl -> jq -> fzf, in parallel for multiple orgs/users
#
# NOTES:
#  No support for private repos/orgs at the moment
#  No support for user/orgs with > 100 repos at the moment.  (100 is the per_page limit of github repo api)
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

    echo $USER_ORGS | \
        xargs -L1 '-I_repo_' \
            echo bash -c "\"curl 'https://api.github.com/_repo_/repos?per_page=100&page=1' 2>/dev/null \
                 | jq --stream -r 'select(.[0][1] == \\\"full_name\\\") | .[1]'\""  \
                 | parallel --line-buffer \
                 | fzf \
                 | read -l repo

    if test -n "$repo"
        rm t
        echo "Opening '$repo' in Github"
        hub browse $repo
    end
end
