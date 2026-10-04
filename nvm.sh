#!/bin/bash

source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/check.sh
source ./utils/log.sh

check "brew" || exit
check "fish" || (echo "Did you forget to run ./fish.sh first?" ; exit)
fish -c "type -q fisher" || { echo "Did you forget to run ./fish.sh first?" ; exit 1; }

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Nvm?" || exit

    echo "Uninstalling nvm"
    rm -rf ~/.nvm/

    fish -c "fisher remove jorgebucaran/nvm.fish"
    exit
fi

logStep "Installing nvm"
fish -c "fisher install jorgebucaran/nvm.fish"

logStep "Installing latest node"
echo "nvm install (nvm ls-remote | tail -n 1)" | fish
