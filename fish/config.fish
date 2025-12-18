# ---------------------------------
# ALIASES
# ---------------------------------

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
alias vlc "/Applications/VLC.app/Contents/MacOS/VLC"

# ALIASES - macos
alias hide_desktop_icons "defaults write com.apple.finder CreateDesktop false & killall Finder"
alias show_desktop_icons "defaults write com.apple.finder CreateDesktop true & killall Finder"

# ALIASES - vim
alias edvim "vim ~/.vimrc"

# ---------------------------------
# FISH CONFIG
# ---------------------------------

# FISH CONFIG - color
set fish_color_search_match --background=4F5B66
set fish_color_error red  # invalid command color
set fish_color_command 6699CC # valid command color
set fish_pager_color_prefix C594C5      # suggestion prefix
set fish_pager_color_completion 6699CC # suggestion completition
set fish_color_redirection yellow

# FISH-CONFIG - generic
set fish_greeting # remove greeting message

# Vi bindings
fish_vi_key_bindings

# ---------------------------------
# PATH
# ---------------------------------
fish_add_path /usr/local/bin ~/bin/ /opt/homebrew/bin/ node_modules/.bin

# Always use `fish_add_path` here in this file (or in interactive shell). It will do the right thing.
#    - This will appended entries inside a variable `echo $fish_user_paths` which is automatically loaded inside PATH
#    - To reset it use `set -eU fish_user_paths`

# If $PATH inside fish acts weird, always check the path outside of tmux
# looks like tmux is sharing some path with the children


# ---------------------------------
# OTHERS
# ---------------------------------

# OTHER - Android
# set -gx ANDROID_SDK_ROOT /opt/homebrew/share/android-commandlinetools
set -gx JAVA_HOME /opt/homebrew/opt/openjdk@11
# set -gx ANDROID_HOME /opt/homebrew/share/android-commandlinetools
set -gx ANDROID_HOME /Users/max.gallo/Library/Android/sdk
set -gx ANDROID_NDK_HOME /Users/max.gallo/Library/Android/sdk/ndk/28.1.13356709

# this is to access "aapt" command
fish_add_path $ANDROID_HOME/build-tools/35.0.0

# OTHER - Amazon Kepler
set -gx KEPLER_SDK_PATH /Users/max.gallo/kepler/sdk/0.20.3719
fish_add_path $KEPLER_SDK_PATH/bin $KEPLER_SDK_PATH/bin/tools

# OTHER - AWS CLI
# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# OTHER - NVM
set -gx NVM_DIR ~/.nvm

# OTHER - FZF
# More interesting things here
# https://medium.com/@sidneyliebrand/how-fzf-and-ripgrep-improved-my-workflow-61c7ca212861
alias vif "vim -O (fzf --multi)"
set -gx FZF_DEFAULT_OPTS '--height=50% --min-height=15 --reverse'
set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

# OTHER - (like GITHUB token
# Load secrets from separate file (not tracked in git)
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

# OTHER - Atuin
set -gx ATUIN_NOBIND "true"
atuin init fish | source
# bind to ctrl-r in normal and insert mode
bind \cr _atuin_search
bind -M insert \cr _atuin_search
# TODO: have a look https://news.ycombinator.com/item?id=43478236


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/max.gallo/github/getndazn/feeds-collector/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/max.gallo/github/getndazn/feeds-collector/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/max.gallo/github/getndazn/feeds-collector/node_modules/tabtab/.completions/sls.fish ]; and . /Users/max.gallo/github/getndazn/feeds-collector/node_modules/tabtab/.completions/sls.fish
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/max.gallo/github/getndazn/feeds-collector/node_modules/tabtab/.completions/slss.fish ]; and . /Users/max.gallo/github/getndazn/feeds-collector/node_modules/tabtab/.completions/slss.fish

# pyenv init - | source
# had to disable this since from time to time a new terminal froze (even inside vim)
# and gotpyenv: cannot rehash: /Users/max.gallo/.pyenv/shims/.pyenv-shim exists

# Ruby
# status --is-interactive; and rbenv init - fish | source


# Hydro
set hydro_color_pwd yellow
set hydro_color_git green
set hydro_color_prompt blue

# https://gist.github.com/xto3na/be59699271121180e079
set hydro_symbol_git_dirty " ✖"
