#!/bin/bash
source ../utils/confirm.sh
source ../utils/check.sh
source ../utils/log.sh

check "jq" || (echo "jq is mandatory to run this script" ; exit)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to disinstall Shuttle ?" || exit

    logStep "Uninstalling Shuttle"
    rm -rf ~/Applications/Shuttle.app
    rm ~/.shuttle.json

    exit
fi

logStep "Installing Shuttle"
latest_version=$(curl --silent "https://api.github.com/repos/fitztrev/shuttle/releases/latest" | jq -r .tag_name);
rm -f ~/Downloads/Shuttle.zip
curl \
    --output ~/Downloads/Shuttle.zip \
    --location \
    https://github.com/fitztrev/shuttle/releases/download/$latest_version/Shuttle.zip
unzip ~/Downloads/Shuttle.zip -d ~/Downloads/ -x "__MACOSX/*"
cp -r ~/Downloads/Shuttle.app ~/Applications/Shuttle.app
open ~/Applications/Shuttle.app
