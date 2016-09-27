# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/"$USER"/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/max.gallo/.config/omf"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# my stuff - START
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# fish related
alias edfish "sublime ~/.config/fish/config.fish"
alias fish_reload_config "source ~/.config/fish/config.fish"
alias server "python -m SimpleHTTPServer"
alias sslserver "python ~/scripts/sslserver.py"
alias ll "ls -al"
alias nodefolder "echo /usr/local/opt/nvm/versions/node/v5.7.1/bin/node"
alias ednginx "vim /usr/local/etc/nginx/nginx.conf"

# set -g fish_term24bit 1
# fish related commands
# fish_config : opens the browser with the config web

set -x GOPATH ~ # the -x flag exports the variable
set PATH $PATH $GOPATH/bin

# powerline specific
alias powerline-update "powerline-daemon --replace"


# COLOR
set fish_color_search_match --background=4F5B66
set fish_color_error red  # invalid command color
set fish_color_command 6699CC # valid command color
set fish_pager_color_prefix C594C5      # suggestion prefix
set fish_pager_color_completion 6699CC # suggestion completition
set fish_color_redirection yellow

#set fish_function_path $fish_function_path "/Users/max.gallo/Library/Python/2.7/lib/python/site-packages/powerline/bindings/fish"
#powerline-setup

function fish_prompt
    ~/powerline-shell/powerline-shell.py $status --shell bare ^/dev/null --colorize-hostname
end

# NVM
#set -gx NVM_DIR (brew --prefix nvm)
set -gx NVM_DIR ~/.nvm


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# my stuff - END
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
