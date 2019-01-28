#!/bin/bash
source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/log.sh

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Tmux and reset the configuration?" || exit

    echo "Uninstalling Tmux"
    brew uninstall tmux

    echo "Removing ~/.tmux.conf file"
    rm ~/.tmux.conf

    exit
fi

logStep "Installing Tmux"
brew install tmux

logStep "Symlinking .tmux.conf file"
rm ~/.tmux.conf
ln -s "$dotfiles_folder/tmux/.tmux.conf" ~/.tmux.conf

# TODO
# Add override of the CAPSLOCK

