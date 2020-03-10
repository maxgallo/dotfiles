#!/bin/bash

source ../utils/confirm.sh
source ../utils/config.sh
source ../utils/log.sh

eslint_packages=(
    eslint
    babel-eslint
    eslint-plugin-react
    @typescript-eslint/parser
)

# Remove if --remove variable is present
if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall ESLINT ?" || exit

    echo "Removing ~/.eslintrc"
    rm -rf ~/.eslintrc

    echo "Uninstalling NPM global packages"
    for i in "${eslint_packages[@]}"
    do
        :
        echo "  uninstalling \"$i\""
        npm uninstall --global "$i"
    done

    exit
fi

logStep "Installing NPM global packages"
for i in "${eslint_packages[@]}"
do
    :
    echo -e "\ninstalling \"$i\""
    npm install --global "$i"
done

logStep "Symlinking ~/.eslintrc file"
ln -s "$dotfiles_folder/eslint/.eslintrc" ~/.eslintrc
