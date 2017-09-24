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

brew tap fisherman/tap
brew tap caskroom/cask

brew install \
    git \
    jq \
    ansible \
    hub

brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package quicklookase qlvideo

# install fish shell
brew install \
    fish

echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# fisher for completions
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish -c "fisher barnybug/docker-fish-completion"
fish -c "fisher ansible-completion"

brew cask install \
    docker \
    java \
    virtualbox \
    visual-studio-code 

#TODO: Add VS 'code' command line shortcut   "Shell Command: Install 'code' command in PATH"

