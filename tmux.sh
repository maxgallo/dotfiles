#!/bin/bash
source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/log.sh
source ./utils/brew-utils.sh
source ./utils/file_system.sh

mandatoryBrew

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Tmux and reset the configuration?" || exit

    echo "Uninstalling Tmux"
    brew uninstall tmux

    echo "Removing ~/.tmux.conf file"
    rm ~/.tmux.conf

    echo "Removing anything related to tmux"
    rm -rf ~/.tmux/

    exit
fi

logStep "Installing Tmux"
brew install tmux

logStep "Installing  Tmux Plugin Manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

logStep "Symlinking .tmux.conf file"
removeIfExists ~/.tmux.conf
ln -s "$dotfiles_folder/tmux/.tmux.conf" ~/.tmux.conf

# TODO
# Add override of the CAPSLOCK

# Reload Config file
tmux source-file ~/.tmux.conf
# Install plugins (the first time only - same as prefix+I as per Installing)
~/.tmux/plugins/tpm/scripts/install_plugins.sh
echo -e "To install the p"
