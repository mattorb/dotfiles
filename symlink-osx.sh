#!/bin/bash

ln -sf $(pwd)/git/.gitconfig $HOME/.gitconfig

mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh
ln -sf $(pwd)/ssh/config $HOME/.ssh/config
