#!/bin/bash

# Copied from here
# https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8#gistcomment-2758561

function get_download_url {
    wget -q -nv -O- https://api.github.com/repos/$1/$2/releases/latest 2>/dev/null |  jq -r '.assets[] | select(.browser_download_url | contains("darwin")) | .browser_download_url'
}

function install_binary {
    URL=$(get_download_url $1 $2)
    mkdir -p ~/bin
    BASE=$(basename $URL)
    wget -q -nv -O $BASE $URL
    if [ ! -f $BASE ]; then
        echo "Didn't download $URL properly.  Where is $BASE?"
        exit 1
    fi
    DESTINATION=~/bin/$3
    mv $BASE $DESTINATION
    chmod +x $DESTINATION
    echo "🎉 New binary available at $DESTINATION"
}
