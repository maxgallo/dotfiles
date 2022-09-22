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

    echo "omf uninstall https://github.com/edc/bass" | fish
    echo "omf uninstall https://github.com/fabioantunes/fish-nvm" | fish

    exit
fi

logStep "Installing nvm"
mkdir -p ~/.nvm/
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# This causes fish shell to take between 0.5s and 1s to load.
#
# You can test yourself with
#   time fish -c "echo hello"
# and check the differencies with ~10ms of
#   time bash -c "echo hello"
#
# This affect not only opening a new shell, but using commands like `fzf`
# logStep "Installing nvm for Oh My Fish"
# echo "omf uninstall nvm" | fish
# echo "omf install nvm" | fish
#
# To fix the problem, this was created https://github.com/FabioAntunes/fish-nvm
# now the command above in fish, takes ~70ms
echo "omf install https://github.com/fabioantunes/fish-nvm" | fish
echo "omf install https://github.com/edc/bass" | fish

# this will source node when opening VIM
nvm_alias_function vim

logStep "Installing latest node"
echo "nvm install (nvm ls-remote | tail -n 1)" | fish
