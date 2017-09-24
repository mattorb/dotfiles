#!/usr/bin/env bash
ROOT="$(pwd)"

set -e

install_dotfiles () {
    files=$(find "$ROOT/dots" -maxdepth 1 -print);
    linkfiles=$(echo "$files" | grep -vE '(/dots$|\.DS_Store|_\..$|_\.$)')

    echo 'Installing dot files...'

    for source in $linkfiles; do
        file_base=$(basename "${source}")
        dest="$HOME/$file_base"

        if [ -h "$dest" ] && [ $(readlink "$dest") = $source ]; then
            echo "Sym link already exists.  Skipping $dest"
            continue;
        else
             echo "Linking $source -> $dest"
             ln -s "$source" "$dest"
        fi
    done

    echo "Finished linking dot files"
}

main () {
    install_dotfiles

    git config --global core.excludesfile $HOME/.gitignore_global

    if [[ $(uname -s) == "Darwin" ]]; then
        "$ROOT/osx.sh"
    elif [[ $(uname -s) == "Linux" ]]; then
        "$ROOT/linux.sh"
    fi
}

main

echo All Done!
