#!/bin/bash
source ./utils/config.sh
source ./utils/confirm.sh
source ./utils/log.sh
source ./utils/file_system.sh

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall .zshrc and .zshenv?" || exit

    logStep "Removing .zshrc"
    rm ~/.zshrc

    logStep "Removing .zshenv"
    rm ~/.zshenv

    exit
fi

logStep "Symlinking .zshrc"
removeIfExists ~/.zshrc
ln -s "$dotfiles_folder/zsh/zshrc" ~/.zshrc

logStep "Symlinkin .zshenv"
removeIfExists ~/.zshenv
ln -s "$dotfiles_folder/zsh/zshenv" ~/.zshenv
