function pset -d "Read a password, masked from stdin, and set an environment var with it.  PW value is not logged in command history or shown on screen."
    if test (count $argv) = 0
        echo "Missing required argument: environment variable name"
        return 1
    end
    
    set VAR $argv[1]

    read -g -s -P "Set $VAR to (masked): " $VAR
end