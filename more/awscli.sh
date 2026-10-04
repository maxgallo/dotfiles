#!/bin/bash
source ../utils/confirm.sh
source ../utils/check.sh
source ../utils/log.sh

check "brew" || (echo "brew is mandatory to install/disisntall AWS cli" ; exit)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to disinstall AWS cli?" || exit

    logStep "Uninstalling AWS CLI"
    brew uninstall awscli

    exit
fi

logStep "Installing AWS CLI"
brew install awscli # fish autocompletion is configured in fish/config.fish
