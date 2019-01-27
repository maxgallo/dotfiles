#!/bin/bash
source ./utils/confirm.sh
source ./utils/config.sh

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Tmux?" || exit

    echo "Uninstalling Tmux"
    brew uninstall tmux

    echo "Removing ~/.tmux.conf file"
    rm ~/.tmux.conf

    exit
fi

echo "Installing Tmux"
brew install tmux

echo "Symlinking .tmux.conf file"
rm ~/.tmux.conf
ln -s "$dotfiles_folder/tmux/.tmux.conf" ~/.tmux.conf

