#!/bin/bash

source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/check.sh

check "brew" || echo "we need brew to do stuff :(" ; exit

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Fish Shell?" || exit

    echo "omf uninstall nvm" | fish
    echo "Uninstalling Oh My Fish"
    curl -L http://get.oh-my.fish > install
    fish install --uninstall
    brew uninstall fish      # removing fish

    echo "Uninstalling powerline"
    rm -rf ~/powerline-shell # removing old version of powerline
    pip3 uninstall -y powerline-shell # removing new version of powerline shell
    rm -rf ~/.config/powerline-shell

    exit
fi

check "brew" || exit
check "pip3" || exit

# Installine powerline shell
pip3 install powerline-shell
mkdir -p ~/.config/powerline-shell/custom-segments
# cp "$dotfiles_folder/fish/powerline-shell/custom-segments/*.py" ~/.config/powerline-shell/custom-segments/
# cp "$dotfiles_folder/fish/powerline-shell/config.json" ~/.config/powerline-shell/config.json
ln -s "$dotfiles_folder/fish/powerline-shell/custom-segments/*.py" ~/.config/powerline-shell/custom-segments/
ln -s "$dotfiles_folder/fish/powerline-shell/config.json" ~/.config/powerline-shell/config.json


# Install fish
if [[ ! "$(type -P fish)" ]]; then
    echo "Installing Fish"
    brew install fish
fi

# Install oh my fish
if [[ ! "$(type -P omf)" ]]; then
    echo "Installing Oh My Fish"
    curl -L http://get.oh-my.fish > install
    fish install --noninteractive --yes
    echo "omf install aws" | fish # AWS cli autocompletion for fish
fi

echo "Symlinking config.fish file"
ln -s "$dotfiles_folder/fish/config.fish" ~/.config/fish/config.fish
