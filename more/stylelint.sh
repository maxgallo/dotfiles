#!/bin/bash

echo "Need Review before run!"
exit

# load variables
. ./var.sh

# CSS linter
npm install -g stylelint stylelint-config-standard
cp $DOTFILES_FOLDER/stylelint/.stylelintrc ~/.stylelintrc
