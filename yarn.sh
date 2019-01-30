#!/bin/bash
source ./utils/confirm.sh
source ./utils/log.sh
source ./utils/check.sh

yarn_packages=(
    serverless
    terraform
    prettier
)

check "yarn" || (echo "Yarn is not installed!" ; exit)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to disinstall Yarn global packages?" || exit

    logStep "Uninstalling Yarn Global packages"
    for i in "${yarn_packages[@]}"
    do
        :
        yarn global remove "$i"
    done

    exit
fi

logStep "Installing Yarn Global packages"
for i in "${yarn_packages[@]}"
do
    :
    yarn global add "$i"
done
