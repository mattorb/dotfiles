#!/usr/bin/env bash
echo Installing desktop apps

set -e

# Bypass upstream xattr issues with quarantine and latest OS X versions
# TODO: remove me when a better solution is avail.
[ ${GITHUB_ACTION} ] && export HOMEBREW_CASK_OPTS="--no-quarantine --appdir=/Applications"

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
    spectacle \
    wireshark \
    keycastr \
    karabiner-elements \
    hammerspoon \
    tunnelblick \
    p4v

# per Karabiner docs, need parent dir sym link, not json config sym link
ln -sf $(pwd)/karabiner $HOME/.config

# force reload after symlink creation
[ -z "$GITHUB_ACTION" ] && launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server

ln -sf $(pwd)/hammerspoon $HOME/.hammerspoon

# Yah . . . this works, svn download a sub-dir of a github repo to a dest dir
svn export https://github.com/mattorb/keyboard/branches/customizations/hammerspoon hammerspoon/keyboard

[ -z "$GITHUB_ACTION" ] && osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Hammerspoon.app", hidden:true}' > /dev/null
[ -z "$GITHUB_ACTION" ] && osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Karabiner-Elements.app", hidden:true}' > /dev/null
[ -z "$GITHUB_ACTION" ] && osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/nvALT.app", hidden:true}' > /dev/null

# Turn off Hammerspoon dock icon
defaults write org.hammerspoon.Hammerspoon MJShowDockIconKey -bool FALSE
killall Hammerspoon || true
open /Applications/Hammerspoon.app