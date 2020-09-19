#!/bin/bash

source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/check.sh
source ./utils/log.sh

check "brew" || exit
check "fish" || (echo "Did you forget to run ./fish.sh first?" ; exit)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Nvm?" || exit

    echo "Uninstalling nvm"
    rm -rf ~/.nvm/

    echo "omf uninstall nvm" | fish

    exit
fi

logStep "Installing nvm"
mkdir -p ~/.nvm/
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

logStep "Installing nvm for Oh My Fish"
echo "omf uninstall nvm" | fish
echo "omf install nvm" | fish

logStep "Installing latest node"
echo "nvm install (nvm ls-remote | tail -n 1)" | fish
