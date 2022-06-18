#!/usr/bin/env bash
echo Configuring mac

set -e

source .cisupport/is_ci.sh
source .cisupport/brewover.sh

if [[ $(xcode-select --version) ]]; then
  echo Xcode command tools already installed
else
  echo "Installing Xcode commandline tools"
  $(xcode-select --install)
fi

if [[ $(brew --version) ]] ; then
    echo "Attempting to update Homebrew from version $(brew --version)"
    brew update
else
    echo "Attempting to install Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
# Bypass upstream xattr issues with quarantine and latest OS X versions.  specifically, quicklook-csv cask install failed
# TODO: remove me when a better solution is avail.  
is_ci && export HOMEBREW_CASK_OPTS="--no-quarantine --appdir=/Applications"

brew update; brew upgrade --cask; brew cleanup || true

echo Effective Homebrew version:
brew --version

brewover go || true
brewover git || true

brew bundle --file=- <<-EOS
tap "homebrew/cask"
brew "ruby"
brew "jq"
brew "diff-so-fancy"
brew "fzf"
brew "parallel"
brew "ripgrep"
brew "swiftformat"
brew "chisel"
brew "hub"
EOS
# exa, dust, multitime "Tenzer/tap/multitime" tap went bad: ref: http://tratt.net/laurie/src/multitime/


brew install --cask swiftformat-for-xcode provisionql qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook suspicious-package quicklookase qlvideo

# last tested ver: fish 3.4.1
brew install fish

echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells
is_ci || sudo -v
is_ci || sudo chsh -s "$(brew --prefix)/bin/fish" $(whoami)

# fisher for completions. 4.1.0
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
is_azure_devops || fish -c "fisher install barnybug/docker-fish-completion"
is_azure_devops || fish -c "fisher install jethrokuan/fzf"
is_azure_devops || fish -c "fisher install derphilipp/enter-docker-fzf"

brew install --cask \
    visual-studio-code 

# Equivalent of VS [gui] Command Palette  "Shell command: Install 'code' command in PATH"
ln -sf /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code $(brew --prefix)/bin/code

code --install-extension lunaryorn.fish-ide --force
code --install-extension fabiospampinato.vscode-todo-plus --force 

ln -sf $(pwd)/prefs/visual-studio-code/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

# only installed when osx, so not in the base template
git config --global core.editor "code -w -n"
git config --global core.pager "diff-so-fancy | less --tabs=1,5 -R"
git config --global pull.rebase true
git config --global rebase.autoStash true

cd src/listrepo
./build.sh
cd ../../

echo '1. Execute this to add ssh key (w/passphrase) to keychain:  ssh-add -K ~/.ssh/id_rsa'
echo '2. Then git config --global user.name "Your Name"'
echo '3. Then git config --global user.email "Your_Email@...com"'
echo '4. Create a git Personal Access token, then:  "hub browse" and enter git user and Access token to configure hub to use that'
echo '5. Install dropbox and Configure dropbox accounts'
echo '6. Configure Slack accounts'
echo '7. Configure nvalt storage backend /Dropbox/Notes and "plain text" format, set hide dock icon, show menu'
echo '8. Install Air Mail from App Store and configure accounts'
echo '9. Add Bartender license, configure bartender'
echo '10. Configure Keepass'
echo '11. Install IDEs'
echo '12. Add cdto to finder toolbar:   Drag Applications/cd to.app onto the Finder toolbar while holding down the command(⌘) and option(⌥) keys'
echo '13. Put a github token in ~/.fhub_token to enable the fhub repo navigation function.  Put additional orgs (to include their public repos) in ~/.fhub_orgs'
echo '14. Launch Hammerspoon.  Set it to start on launch.   Enable Accessibility.'

