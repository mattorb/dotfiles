function dnsflush -d "Flush DNS Cache"
    echo Flushing DNS Cache.   May prompt for sudo password...

    switch (command uname)
        case Darwin \*BSD
            sudo killall -HUP mDNSResponder 2>/dev/null; sudo killall mDNSResponderHelper 2>/dev/null; sudo dscacheutil -flushcache 2>/dev/null
        case \*
            echo Unsupported OS type
    end
end