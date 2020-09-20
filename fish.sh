#!/bin/bash
source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/check.sh
source ./utils/log.sh

check "brew" || (echo "we need brew to do stuff :(" ; exit)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Fish Shell?" || exit

    echo "Uninstalling Oh My Fish"
    curl -L http://get.oh-my.fish > install
    fish install --uninstall

    echo "Uninstalling Fish"
    brew uninstall fish

    echo "Removing Oh My Fish Configuration"
    rm -rf ~/.local/share/omf

    echo "Deleting fish configuration"
    rm -rf ~/.config/fish/

    exit
fi

# Install fish
if [[ ! "$(type -P fish)" ]]; then
    logStep "Installing Fish"
    brew install fish
fi

# Install oh my fish
if [[ ! "$(type -P omf)" ]]; then
    logStep "Installing Oh My Fish"
    curl -L http://get.oh-my.fish > install
    fish install --noninteractive --yes
fi

logStep "Symlinking config.fish file"
rm ~/.config/fish/config.fish 2> /dev/null
ln -s "$dotfiles_folder/fish/config.fish" ~/.config/fish/config.fish

logStep "Symlinking functions"
rm -rf ~/.config/fish/functions 2> /dev/null
ln -s $dotfiles_folder/fish/functions ~/.config/fish/functions
