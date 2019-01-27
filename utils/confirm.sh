#!/bin/bash

default_message="Are you sure?";
color_red='\033[0;31m'
color_reset='\033[0m' # No Color

confirm() {
    local message=${1:-$default_message};
    local message_with_suggestion="$message [y/N] "

    read -p "$(echo -e "$color_red$message_with_suggestion $color_reset")" -n 1 -r
    echo
    case $REPLY in
        [yY])
            true
            ;;
        *)
            false
            ;;
    esac
}
