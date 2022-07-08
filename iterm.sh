#!/bin/bash

source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/check.sh
source ./utils/log.sh

check "brew" || exit
check "fish" || (echo "Did you forget to run ./fish.sh first?" ; exit)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall iTerm2?" || exit

    echo "Uninstalling iTerm2"
    brew cask uninstall iterm2

    exit
fi

logStep "Installing iTerm2"
brew install iterm2 --cask

logStep "Symlinking profiles"
ln -s $dotfiles_folder/iterm/*.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/
