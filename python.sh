#!/bin/bash

brew update
brew install pyenv
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
exec $SHELL
pyenv install 3.5.4
pyenv global 3.5.4

