#!/bin/bash
source ../utils/confirm.sh
source ../utils/brew-utils.sh
source ../utils/log.sh

# "mas search xzy" to search for packages
mas_packages=(
    668208984  # GIPHY Capture. The GIF Maker
    467040476  # HiddenMe
    1497506650 # Yubico Authenticator
)

# Make sure homebrew is installed first
mandatoryBrew

logStep "Installing Mas"
brew install mas

logStep "Installing Mas Packages"

for i in "${mas_packages[@]}"
do
   :
   echo installing $i
   mas install "$i"
done
