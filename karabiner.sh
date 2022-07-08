#!/bin/bash
source ./utils/confirm.sh
source ./utils/check.sh
source ./utils/log.sh
source ./utils/config.sh
source ./utils/brew-utils.sh
source ./utils/file_system.sh

mandatoryBrew

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Karabiner?" || exit

    logStep "Uninstalling Karabiner"
    brew uninstall --cask karabiner-elements

    logStep "Removing Symlink of karabiner.json"
    rm -f ~/.config/karabiner/karabiner.json

    exit
fi

logStep "Install Karabiner"
brew install --cask karabiner-elements

logStep "Symlinking profiles"
removeIfExists ~/.config/karabiner/karabiner.json
mkdir -p ~/.config/karabiner/
ln -s $dotfiles_folder/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

# Open the app to grant the right permissions
open /Applications/Karabiner-Elements.app/
