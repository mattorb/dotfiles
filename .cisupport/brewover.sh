#!/usr/bin/env bash

brewover() { 
    if brew ls --versions "$1"; then 
        brew upgrade "$1"; 
    else 
        brew install "$1"; 
    fi 
}
