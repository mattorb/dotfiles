#!/usr/bin/env bash
echo Configuring mac

set -e

if [[ $(xcode-select --version) ]]; then
  echo Xcode command tools already installed
else
  echo "Installing Xcode commandline tools"
  $(xcode-select --install)
fi

if [[ $(brew --version) ]] ; then
    echo "Attempting to update Homebrew"
    brew update
else
    echo "Attempting to install Homebrew"
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew update && brew cleanup && brew cask cleanup

brew tap caskroom/cask

brew install \
    git \
    ruby \
    go \
    python \
    jq \
    ansible \
    awscli \
    csshX \
    hub \
    diff-so-fancy \
    packer \
    terraform \
    vault \ 
    fzf \
    parallel \
    telnet \ 
    netcat \
    Tenzer/tap/multitime

brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package quicklookase qlvideo

# install fish shell
brew install \
    fish \
    bash

echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# fisher for completions. 3.2.7
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish -c "fisher add barnybug/docker-fish-completion"
fish -c "fisher add ansible-completion"
fish -c "fisher add jethrokuan/fzf"
fish -c "fisher add derphilipp/enter-docker-fzf"

brew cask install \
    docker \
    java \
    virtualbox \
    visual-studio-code 

# Equivalent of VS [gui] Command Palette  "Shell command: Install 'code' command in PATH"
ln -sf /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code /usr/local/bin/code

code --install-extension TeddyDD.fish
code --install-extension PeterJausovec.vscode-docker
code --install-extension haaaad.ansible

ln -sf $(pwd)/prefs/osx/visual-studio-code/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

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
echo '5. Configure dropbox accounts'
echo '6. Configure Slack accounts'
echo '7. Configure nvalt storage backend'
echo '8. Install Air Mail from App Store and configure accounts'
echo '9. Add Bartender license, configure bartender'
echo '10. Configure 1Password vaults'
echo '11. Install IDEs'
echo '12. Add cdto to finder toolbar:   Drag Applications/cd to.app onto the Finder toolbar while holding down the command(⌘) and option(⌥) keys'
echo '13. Configure ARQ'
echo '14. Configure Carbon Copy cloner'
echo '15. Launch Spectacle and enable accessibility access.  Then menubar->spectacle->Preferences->Launch at login'
echo '16. Put a github token in ~/.fhub_token to enable the fhub repo navigation function.  Put additional orgs (to include their public repos) in ~/.fhub_orgs'