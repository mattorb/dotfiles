#!/usr/bin/env bash
echo Installing desktop apps

set -e

brew cask install \
    1password \
    arq \
    bartender \
    carbon-copy-cloner \
    cd-to-terminal \
    dropbox \
    nvalt \
    paw \
    slack \
    virtualbox \
    spectacle \
    wireshark \
    keycastr \
    karabiner-elements

mkdir $HOME/.config/karabiner
ln -sf $(pwd)/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json
ln -sf $(pwd)/karabiner/cheatsheets $HOME/.config/karabiner/cheatsheets