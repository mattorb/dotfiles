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

# Equivalent of VS [gui] Command Palette  "Shell command: Install 'code' command in PATH"
ln -sf /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code /usr/local/bin/code

code --install-extension TeddyDD.fish  # .fish lang support

git config --global core.editor "code -w -n"

cat > ~/.ssh/config << EOF
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
EOF

echo "Execute this to add ssh key (w/passphrase) to keychain:  ssh-add -K ~/.ssh/id_rsa"