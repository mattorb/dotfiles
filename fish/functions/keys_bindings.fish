bind --preset $argv \ek 'begin; echo; keys; commandline -f repaint; end'

# Atreus on-screen layer help from cli
# Alt-1 to show keyboard layer 1 help, etc
for x in (string split ' ' '0 1 2 3')
    bind --preset $argv \e$x "begin; qlmanage -p ~/.config/kaleidoscope_with_chrysalis/layer$x.png 1>/dev/null 2>/dev/null; end"
end
