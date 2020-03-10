#!/bin/bash

source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/log.sh

# Remove if --remove variable is present
if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall VIM and reset the configuration?" || exit

    echo "Unistalling vim-plug"
    rm -rf ~/.vim/autoload/plug.vim

    echo "Unistalling All Vim plugins"
    rm -rf ~/.vim/plugged

    echo "Unistalling 'brew' related packages"
    brew uninstall the_silver_searcher

    echo "Unistalling 'npm' related packages"
    npm uninstall -g typescript

    echo "Removing ~/.vimrc configuration file"
    rm ~/.vimrc
    rm ~/.vim/coc-setttings.json

    exit
fi

logStep "Symlinking .vimrc file"
ln -s "$dotfiles_folder/vim/.vimrc" ~/.vimrc

logStep "Installing Silver Searcher"
brew install the_silver_searcher

logStep "Installing typescript"
npm install -g typescript

logStep "Symlinking ~/.vim/coc-settings.json"
ln -s "$dotfiles_folder/vim/coc-setttings.json" ~/.vim/coc-settings.json
