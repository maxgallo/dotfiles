#!/bin/bash
source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/check.sh
source ./utils/log.sh
source ./utils/file_system.sh

check "herdr" || (echo "we need herdr to do stuff :(" ; exit)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to remove the Herdr configuration?" || exit

    echo "Removing ~/.config/herdr/config.toml symlink"
    removeIfExists ~/.config/herdr/config.toml

    exit
fi

logStep "Symlinking config.toml file"
mkdir -p ~/.config/herdr
removeIfExists ~/.config/herdr/config.toml
ln -s "$dotfiles_folder/herdr/config.toml" ~/.config/herdr/config.toml

logStep "Reloading the running Herdr server (if any)"
herdr server reload-config 2> /dev/null || echo "no server running, config applies on next launch"
