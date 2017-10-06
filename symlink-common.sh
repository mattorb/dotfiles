#!/bin/bash

ln -sf $(pwd)/git/.gitaliases $HOME/.gitaliases

mkdir -p $HOME/.config/fish
ln -sf $(pwd)/fish/functions "$HOME/.config/fish"
ln -sf $(pwd)/fish/config.fish "$HOME/.config/fish/config.fish"

ln -sf $(pwd)/bin $HOME