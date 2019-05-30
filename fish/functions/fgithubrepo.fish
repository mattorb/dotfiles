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
    
    # Create a queue to feed FZF with
    set QUEUE (mktemp -ut fgithubrepo_cache)
    mkfifo $QUEUE

    # Async, get in line to feed persisted cache results to the queue
    cat $CACHE 2>/dev/null > $QUEUE &

    # Async fetch repo list via github API
    # Get in line to send results in parallel (tee) to:  1. Persisted cache. 2. queue (fifo)
    listrepo_gql (cat $HOME/.fhub_token) $ADD_ORGS | tee $CACHE > $QUEUE &

    # Feed the queue to fzf, de-duping (w/nauniq) since persisted cache is likely to have heavy overlap with realtime results 
    #   if the cache was populated.
    cat $QUEUE | nauniq | fzf | read -l repo
     
    # Serial example w/o fifo queue.  Gets stuck on waiting for both to finish before sending anything to fzf
    #cat $CACHE 2>/dev/null; listrepo_gql (cat $HOME/.fhub_token) $ADD_ORGS | tee $CACHE | fzf | read -l repo

    if test -n "$repo"
        $COMMAND $repo
    end

    rm $QUEUE
end