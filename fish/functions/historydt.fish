function historydt -d "History search w/datetime. Optional pass text to match on"
    builtin history search --show-time="%a %m-%d %R " | grep "$argv"
end
