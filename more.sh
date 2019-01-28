#!/bin/bash
source ./utils/confirm.sh
source ./utils/log.sh

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to disinstall all this stuff?" || exit

    logStep "Uninstalling AWS CLI"
    brew uninstall awscli
    echo "omf uninstall aws" | fish

    exit
fi

logStep "Installing AWS CLI"
brew install awscli
echo "omf install aws" | fish # fish autocompletion for aws
