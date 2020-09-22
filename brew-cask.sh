#!/bin/bash
source ./utils/confirm.sh
source ./utils/brew-utils.sh

brew_cask_packages=(
    # Browsers
    google-chrome
    google-chrome-canary
    firefox
    firefox-developer-edition
    firefox-nightly
    opera

    # More
    drawio # Macosx desktop client
    macdown # Markdown client
    visual-studio-code
    slack
    charles # Proxy
    virtualbox
    notion
    docker
    dropbox
    1password
    postman

    # Quick look plugins (https://github.com/sindresorhus/quick-look-plugins)
    qlcolorcode
    qlstephen
    qlmarkdown
    quicklook-json

    # Design
    deckset
    sketch

    # More
    tidal
    cyberduck
    rectangle # move and resize windows
    discord
)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to disinstall Brew and all the packages?" || exit

    for i in "${brew_cask_packages[@]}"
    do
        :
        brew cask uninstall "$i"
    done

    uninstallBrew
    exit
fi

# Make sure homebrew is installed first
mandatoryBrew

brew tap homebrew/cask
brew tap homebrew/cask-versions
brew tap Yleisradio/terraforms
brew doctor
brew update

echo "Installing Brew packages"

for i in "${brew_packages[@]}"
do
   :
   brew install "$i"
done

# Post installation
tfenv install # this will install latest package

echo "Installing Cask packages"

for i in "${brew_cask_packages[@]}"
do
   :
   brew cask install "$i"
done
