#!/bin/bash

# load variables
. ./var.sh

# CSS linter
npm install -g stylelint stylelint-config-standard
cp $DOTFILES_FOLDER/stylelint/.stylelintrc ~/.stylelintrc
