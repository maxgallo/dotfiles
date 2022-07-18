# ALIASES

# ALIASES - fish related
alias edfish "vim ~/.config/fish/config.fish"
alias fish_reload_config "source ~/.config/fish/config.fish"

# ALIASES - utilities
alias server "python -m SimpleHTTPServer"
alias sslserver "python ~/scripts/sslserver.py"
alias nodefolder "echo (nvm which latest)"
alias airport "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# ALIASES - functionality replacements
alias ll "exa -bgHliS"
alias cat "bat"
alias ping "prettyping --nolegend"
alias du2 "ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias help "tldr"
alias vimlight "vim --cmd 'let LIVE_CODING=1'"

# set -g fish_term24bit 1
# fish related commands
# fish_config : opens the browser with the config web

# GO stuff
#set -x GOPATH ~ # the -x flag exports the variable
#set PATH $PATH $GOPATH/bin
set PATH /usr/local/bin ~/bin/ /opt/homebrew/bin/ node_modules/.bin $PATH

# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'


# powerline specific
alias powerline-update "powerline-daemon --replace"

# COLOR
set fish_color_search_match --background=4F5B66
set fish_color_error red  # invalid command color
set fish_color_command 6699CC # valid command color
set fish_pager_color_prefix C594C5      # suggestion prefix
set fish_pager_color_completion 6699CC # suggestion completition
set fish_color_redirection yellow

# Generic FISH
set fish_greeting # remove greeting message

# function fish_prompt
    # powerline-shell --shell bare $status
# end

# NVM
set -gx NVM_DIR ~/.nvm

# Vim related
alias edvim "vim ~/.vimrc"

# Vi bindings
fish_vi_key_bindings

# FZF
# More interesting things here
# https://medium.com/@sidneyliebrand/how-fzf-and-ripgrep-improved-my-workflow-61c7ca212861
alias vif "vim -O (fzf --multi)"
set -gx FZF_DEFAULT_OPTS '--height=50% --min-height=15 --reverse'
set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'
