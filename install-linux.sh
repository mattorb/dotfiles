#!/usr/bin/env bash
echo Configuring Linux

# Install FISH - CentOS 7
cd /etc/yum.repos.d/
yum install wget -y
wget https://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo
yum install fish -y

chsh -s /usr/bin/fish
exec fish
