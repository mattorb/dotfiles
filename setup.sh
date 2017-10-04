#!/usr/bin/env bash
ROOT="$(pwd)"

set -e

main () {
    "$ROOT/symlink-common.sh"

    if [[ $(uname -s) == "Darwin" ]]; then
        "$ROOT/config-osx.sh"
        "$ROOT/install-osx.sh"
        "$ROOT/symlink-osx.sh"
    elif [[ $(uname -s) == "Linux" ]]; then
        "$ROOT/install-linux.sh"
        "$ROOT/symlink-linux.sh"
    fi

    "$ROOT/config-common.sh"
}

main

echo All Done!
echo Restarting shell
exec "$(which $SHELL)" -l
