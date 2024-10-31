#!/usr/bin/env bash
echo Installing desktop apps

set -e

source .cisupport/is_ci.sh

# Bypass upstream xattr issues with quarantine and latest OS X versions.  specifically, dropbox cask install failed
# TODO: remove me when a better solution is avail.
is_ci && export HOMEBREW_CASK_OPTS="--no-quarantine --appdir=/Applications"

brew install --cask \
    bartender \
    cd-to \
    paw \
    slack \
    wireshark \
    keycastr \
    hammerspoon \
    obsidian

# Disabling arq where the cask does not seem to stay current

# Disabling p4v where the binary appears to change without version revs (according to sha checksum comparison failures)

# atreus help images
ln -sf $(pwd)/hw/atreus/kaleidoscope_with_chrysalis $HOME/.config

ln -sf $(pwd)/hammerspoon $HOME/.hammerspoon


# sparse checkout https://github.com/mattorb/keyboard/branches/customizations/hammerspoon
git clone --filter=blob:none --no-checkout https://github.com/mattorb/keyboard
cd keyboard
git sparse-checkout init --cone
git sparse-checkout set hammerspoon
git checkout customizations
cd ..

is_ci || osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Hammerspoon.app", hidden:true}' > /dev/null
is_ci || osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Obsidian.app", hidden:true}' > /dev/null

# Turn off Hammerspoon dock icon
defaults write org.hammerspoon.Hammerspoon MJShowDockIconKey -bool FALSE
killall Hammerspoon || true
is_ci || open /Applications/Hammerspoon.app