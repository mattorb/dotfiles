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

# per Karabiner docs, need parent dir sym link, not json config sym link
ln -sf $(pwd)/karabiner $HOME/.config
# force reload after symlink creation
launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server
