#!/bin/bash

color_red='\033[0;31m'
color_reset='\033[0m' # No Color

check() {
    local what_to_check=$1

    if [[ "$(type -P "$what_to_check")" ]];
    then
        true
    else
        echo -e "$color_red\"$what_to_check\" is not available!$color_reset"
        false
    fi
}
