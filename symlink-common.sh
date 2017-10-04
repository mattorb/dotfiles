#!/bin/bash

ln -sf $(pwd)/git/.gitconfig $HOME/.gitconfig

mkdir -p $HOME/.config/fish
ln -sf $(pwd)/fish/completions "$HOME/.config/fish"
ln -sf $(pwd)/fish/functions "$HOME/.config/fish"
ln -sf $(pwd)/fish/config.fish "$HOME/.config/fish/config.fish"
ln -sf $(pwd)/fish/aliases.fish "$HOME/.config/fish/aliases.fish"

