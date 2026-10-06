function removeIfExists () {
    local file_path=$1

    if [ -e $file_path ];
    then
        echo -e "$color_red removing file \"$file_path\""
        rm $file_path
    fi
}

# Replaces a file with a symlink, keeping a backup if it was a real file
function linkWithBackup () {
    local source_file=$1
    local target=$2

    if [ -f "$target" ] && [ ! -L "$target" ]; then
        echo "backing up $target to $target.bak"
        mv "$target" "$target.bak"
    fi
    rm -f "$target"
    ln -s "$source_file" "$target"
}
