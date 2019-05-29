function fgithubrepo -d 'Present an fzf chooser for a github repo.  Put personal access token in $HOME/.fhub_token and additional orgs in $HOME/.fhub_orgs'
    if not test -e "$HOME/.fhub_token"
        echo "Put github personal access token in $HOME/.fhub_token"
        return 1
    end
    
    if test -e "$HOME/.fhub_token"
        read -z ADD_ORGS < $HOME/.fhub_orgs
    end 

    if test -e $argv[1]
        echo Pass the function/command name to invoke when a repo is selected. Repo will be passed as first argument.
        return
    end

    set COMMAND $argv[1]
    set TOKEN (cat $HOME/.fhub_token)
    set ARG_SHA (echo $TOKEN $ADD_ORGS | shasum -a 512 | awk '{print $1}')
    set CACHE ~/.fhub_repo_list_cache.txt-$ARG_SHA
    set ITEMS (cat $CACHE 2>/dev/null| wc -l)
    
    # Immediately send cached records to FZF, and kick off refreshing the cache via listrepo . . . piping that to FZF as we receive.
    # nauniq dedupes it for fzf.  It's critical that output from the first thing not wait on the second to start populating FZF UI, 
    # thus the custom fifo.
    set FIFO (mktemp -ut tem)
    rm -f $FIFO
    mkfifo $FIFO
    cat $CACHE 2>/dev/null > $FIFO &
    listrepo_gql (cat $HOME/.fhub_token) $ADD_ORGS | tee $CACHE > $FIFO &
    cat $FIFO | nauniq | fzf | read -l repo
     
    # Serial example.  Gets stuck on waiting for both to finish before sending anything to fzf
    #cat $CACHE 2>/dev/null; listrepo_gql (cat $HOME/.fhub_token) $ADD_ORGS | tee $CACHE | fzf | read -l repo

    if test -n "$repo"
        $COMMAND $repo
    end

    rm $FIFO
end