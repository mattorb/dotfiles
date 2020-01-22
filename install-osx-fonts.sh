#!/usr/bin/env bash
set -e

echo Installing JetBrains Mono, a developer centric font -- https://www.jetbrains.com/lp/mono/

curl -LO https://download.jetbrains.com/fonts/JetBrainsMono-1.0.0.zip 2>/dev/null
unzip -o JetBrainsMono-1.0.0.zip -d ~/Library/Fonts/
rm JetBrainsMono-1.0.0.zip