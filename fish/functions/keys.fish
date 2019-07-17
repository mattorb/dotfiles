function keys -d "Help for bound keys"
    echo Alt-K\tShow this help keeping current command line
    echo

    echo Buffer/Line
    echo --------------------------------------------------
    echo Alt-\<\t Move cursor to beginning of Buffer
    echo Alt-\>\t Move cursor to end of buffer
    echo Ctrl-A\t Move cursor to beginning line 
    echo Ctrl-E\t Move cursor to end of line
    echo Ctrl-U\t Delete to beginning of line \(to killring\)
    echo Ctrl-K\t Delete to end of line \(to killlring\)
    echo 

    echo Word, Character, killring, history
    echo --------------------------------------------------
    echo Ctrl-W\t Delete back a word \(to killring\)
    echo Alt-D\t Delete forward word \(to killring\)
    echo Alt-T\t Transpose last two words
    echo Alt-C\t Captialize current word
    echo Alt-U\t Uppercase current word
    echo Option-Left\t Move cursor to next word
    echo Option-Right\t Move cursor to previous word
    echo Alt-L\t list contents of directory under cursor
    echo Ctrl-T\t Transpose last two characters
    echo Fn-Del\t Forward Delete a character
    echo Ctrl-Y\t Paste last killring entry
    echo Alt-Y\t Rotate back a killring entry
    echo Alt-Shift-Left/Right\t On empty command line, navigate directory history
    echo Alt-Up/Down\t Search history for token at cursor     \(fish\)
    echo

    echo fzf fish add-ons
    echo ---------------------------------------------------------
    echo Ctrl-R\t search history w/fzf+preview
    echo Ctrl-F\t insert a file path \(starts from token under by cursor\)
    echo Alt-O\t change into subdirectories \(starts from token by cursor\)
    echo Ctrl-O\t open file using default editor
    echo Ctrl-G\t open file using system bound app \(pdf/img/etc\)
end