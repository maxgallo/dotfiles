#!/bin/bash

source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/check.sh
source ./utils/log.sh

check "brew" || (echo "we need brew to do stuff :(" ; exit)
check "pip3" || (exit "we need pip3!" ; exit)


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

    echo "Uninstalling powerline"
    rm -rf ~/powerline-shell # removing old version of powerline
    pip3 uninstall -y powerline-shell # removing new version of powerline shell
    rm -rf ~/.config/powerline-shell

    exit
fi

logStep "Installing Powerline Shell"
pip3 install powerline-shell
mkdir -p ~/.config/powerline-shell/custom-segments
# cp "$dotfiles_folder/fish/powerline-shell/custom-segments/*.py" ~/.config/powerline-shell/custom-segments/
# cp "$dotfiles_folder/fish/powerline-shell/config.json" ~/.config/powerline-shell/config.json
# if we use the double quotes, we get a *.py file created
ln -s $dotfiles_folder/fish/powerline-shell/custom-segments/*.py ~/.config/powerline-shell/custom-segments/
ln -s "$dotfiles_folder/fish/powerline-shell/config.json" ~/.config/powerline-shell/config.json


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
rm ~/.config/fish/config.fish
ln -s "$dotfiles_folder/fish/config.fish" ~/.config/fish/config.fish
