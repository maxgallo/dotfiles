function removeIfExists () {
    local file_path=$1

    if [ -e $file_path ];
    then
        echo -e "$color_red removing file \"$file_path\""
        rm $file_path
    fi
}
