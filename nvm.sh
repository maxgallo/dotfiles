#!/bin/bash

source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/check.sh

check "brew" || exit
check "fish" || echo "Did you forget to run ./fish.sh first?" ; exit
check "omf" || echo "Did you forget to run ./fish.sh first?" ; exit

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Nvm?" || exit

    echo "Uninstalling nvm"
    rm -rf ~/.nvm/
    echo "omf uninstall nvm" | fish

    exit
fi

echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

echo "Installing nvm for Oh My Fish"
echo "omf install nvm" | fish

echo "nvm install 8.10" | fish
