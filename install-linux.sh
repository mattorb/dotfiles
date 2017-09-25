#!/usr/bin/env bash
echo Configuring Linux

# install fish shell
apt-add-repository -y ppa:fish-shell/release-2
apt update -y && apt install -y fish

echo "/usr/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/bin/fish
