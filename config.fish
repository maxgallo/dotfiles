
# fish related
alias edfish "sublime ~/.config/fish/config.fish"
alias fish_reload_config "source ~/.config/fish/config.fish" 

# set -g fish_term24bit 1
# fish related commands
# fish_config : opens the browser with the config web


# powerline specific
alias powerline-update "powerline-daemon --replace"


# COLOR
set fish_color_search_match --background=4F5B66
# # set fish_color_selection --background=red

set fish_color_error red  # invalid command color

set fish_color_command 6699CC # valid command color

set fish_pager_color_prefix C594C5      # suggestion prefix
set fish_pager_color_completion 6699CC # suggestion completition


set fish_color_redirection yellow

set fish_function_path $fish_function_path "/Users/max.gallo/Library/Python/2.7/lib/python/site-packages/powerline/bindings/fish"
powerline-setup

