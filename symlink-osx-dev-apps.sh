#!/bin/bash

mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh
ln -sf $(pwd)/lldb/.lldbinit $HOME/.lldbinit
