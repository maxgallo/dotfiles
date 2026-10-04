#!/bin/bash
source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/check.sh
source ./utils/log.sh

check "brew" || (echo "we need brew to do stuff :(" ; exit)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Fish Shell?" || exit

    echo "Uninstalling Fisher and all plugins"
    fish -c "fisher list | fisher remove"

    echo "Uninstalling Fish"
    brew uninstall fish

    echo "Deleting fish configuration"
    rm -rf ~/.config/fish/

    exit
fi

# Install fish
if [[ ! "$(type -P fish)" ]]; then
    logStep "Installing Fish"
    brew install fish
fi

# Install fisher (it's a fish function, not a binary, so ask fish about it)
if ! fish -c "type -q fisher"; then
    logStep "Installing Fisher"
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

    # nvm.fish is installed by nvm.sh
    fish -c "fisher install franciscolourenco/done" # to show a macos notification on >5s tasks
fi

logStep "Symlinking config.fish file"
rm ~/.config/fish/config.fish 2> /dev/null
ln -s "$dotfiles_folder/fish/config.fish" ~/.config/fish/config.fish

logStep "Symlinking functions"
rm -rf ~/.config/fish/functions 2> /dev/null
ln -s $dotfiles_folder/fish/functions ~/.config/fish/functions
