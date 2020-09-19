#!/bin/bash
source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/install_binary.sh
source ./utils/log.sh

FISH_PROMPT_FILE_PATH=~/.config/fish/functions/fish_prompt.fish

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to disinstall powerline?" || exit

    logStep "Uninstalling powerline-go"
    rm ~/bin/powerline-go

    rm $FISH_PROMPT_FILE_PATH

    exit
fi

logStep "Installing powerline-go..."
install_binary justjanne powerline-go powerline-go

logStep "Enabling it on fish shell ⋊>"
test -f $FISH_PROMPT_FILE_PATH && rm $FISH_PROMPT_FILE_PATH
ln -s $dotfiles_folder/powerline/fish_prompt.fish $FISH_PROMPT_FILE_PATH
