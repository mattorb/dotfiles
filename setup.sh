#!/usr/bin/env bash
ROOT="$(pwd)"
source .cisupport/is_ci.sh

set -e

main () {
    "$ROOT/symlink-common.sh"

    if [[ $(uname -s) == "Darwin" ]]; then
        "$ROOT/install-osx-fonts.sh"
        "$ROOT/config-osx.sh"
        "$ROOT/install-osx-dev-apps.sh"
        "$ROOT/config-git.sh"
        "$ROOT/install-osx-desktop-apps.sh"
        "$ROOT/symlink-osx-dev-apps.sh"
    elif [[ $(uname -s) == "Linux" ]]; then
        "$ROOT/install-linux.sh"
    fi

}

main

find * -name "setup.sh" -not -wholename "packages*" | while read setup; do
    ./$setup
done

echo All Done!
echo Restarting shell
is_azure_devops || exec "$(which $SHELL)" -l
