#!/usr/bin/env bash
ROOT="$(pwd)"

set -e

main () {
    "$ROOT/symlink-common.sh"

    if [[ $(uname -s) == "Darwin" ]]; then
        "$ROOT/config-osx.sh"
        "$ROOT/install-osx-dev-apps.sh"
        "$ROOT/install-osx-desktop-apps.sh"
        "$ROOT/symlink-osx-dev-apps.sh"
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
