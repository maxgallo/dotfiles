alias ll='ls -al'
alias sourcekitsad='rm -rf ~/Library/Developer/Xcode/DerivedData'
alias refresh_bash_profile='source ~/.bash_profile'
alias clear='printf "\033c"'
alias edbash='sublime ~.bash_profile'

export LC_ALL="en_US.UTF-8"
export CLICOLOR=1

# Refresh last chrome tab
refresh_current_chrome_tab() {
    osascript -e '
        tell application "Google Chrome"
          activate
          delay 1
          tell application "System Events"
            tell process "Google Chrome"
              keystroke "r" using {command down, shift down}
            end tell
          end tell
        end tell

        tell application "terminal" to activate
    '
}
export -f refresh_current_chrome_tab



# Start an HTTP server from a directory, optionally specifying the port
function server(){
    local port="${1:-8001}"
    #open "http://macsmbpr.local:${port}/"
    open -a "/Applications/Google Chrome.app" "http://macs.local:${port}/"
    python -m SimpleHTTPServer "$port"
}
export -f server


####### WATCHER start ####
function execute_me_on_file_changes {
    echo -e "file changed"
    refresh_current_chrome_tab
    echo -e " --> action on file changes completed " $(date | awk '{print $4}') "\n"
}
export -f execute_me_on_file_changes


function watchfolder {
    FOLDER=$1
    if [ -z "$FOLDER" ]; then
        echo "No folder specified, using current"
        FOLDER='.'
    fi

    fswatch -o -0 $FOLDER | xargs -0 -n 1 -I {} bash -c 'execute_me_on_file_changes'
}

export -f watchfolder
####### WATCHER end ####




## Powerline shell ##
function _update_ps1() {
    PS1="$(~/powerline-shell/powerline-shell.py $? 2> /dev/null)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi



