function keys -d "Help for bound keys"
    echo Alt-K\tShow this help

    echo Line Level
    echo --------------------------------------------------
    echo Ctrl-A\t Move Cursor to beginning line 
    echo Ctrl-E\t Move Cursor to end of line
    echo Ctrl-U\t Delete to beginning of line \(to killring\)
    echo Ctrl-K\t Delete to end of line \(to killlring\)
    echo 

    echo Word Level
    echo --------------------------------------------------
    echo Ctrl-W\t Delete back a word \(to killring\)
    echo Alt-D\t Delete forward word \(to killring\)
    echo Alt-T\t Transpose last two words
    echo Alt-C\t Captialize current word
    echo Alt-U\t Uppercase current word
    echo Alt-Up\t Search history for token at cursor     \(fish\)
    echo Option-Left\t Move cursor to next word
    echo Option-Right\t Move cursor to previous word
    echo

    echo Character level
    echo --------------------------------------------------
    echo Ctrl-T\t Transpose last two characters
    echo Fn-Del\t Forward Delete a character
    echo

    echo killring
    echo --------------------------------------------------
    echo Ctrl-Y\t Paste last killring entry
    echo Alt-Y\t Rotate back a killring entry
    echo

    echo fzf fish add-ons
    echo ---------------------------------------------------------
    echo Ctrl-R\t search history w/fzf+preview
    echo Ctrl-F\t insert a file path \(starts from token under by cursor\)
    echo Alt-O\t change into subdirectories \(starts from token by cursor\)
    echo Ctrl-O\t open file using default editor
    echo Ctrl-G\t open file using system bound app \(pdf/img/etc\)
end