#!/bin/bash
source ./utils/check.sh
source ./utils/log.sh
source ./utils/config.sh

check "brew" || exit

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Nvm?" || exit

    logStep "Uninstalling Karabiner"
    brew cask uninstall karabiner-elements

    logStep "Removing Symlink of karabiner.json"
    rm -f ~/.config/karabiner/karabiner.json

    exit
fi

logStep "Install Karabiner"
brew cask install karabiner-elements

logStep "Symlinking profiles"
rm -f ~/.config/karabiner/karabiner.json
ln -s $dotfiles_folder/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
