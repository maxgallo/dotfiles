#!/bin/bash

function removeOldFiles() {

}

function copyNewFiles() {
	cp .bash_profile ~/.bash_profile
	cp .vimrc ~/.vimrc
}

function doId() {
	removeOldFiles
	copyNewFiles
	source ~/.bash_profile
}


# Main
if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r
echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi




# Install Homebrew on OS X
if [[ $(uname) == 'Darwin' ]]; then
	read -p "Would you like to set up Homebrew? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./brew.sh
	fi

	read -p "Would you like to set up macOS preferences? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./macos.sh
	fi

	read -p "Would you like to set up fish shell ? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./fish.sh
	fi
fi


