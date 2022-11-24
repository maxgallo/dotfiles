# Max's dotfiles
My personal collection of dotfiles.

## How it works ?
There are a few fundamental scripts and then a bunch more inside the `more` folder.
Removing or adding functionalities atomically works better than a single `installeverything.sh` for me. It avoids broken states and isolate problems with scripts.

## Available Scripts
```bash
./macos.sh      # Set all macOS defaults
./brew.sh       # Install brew packages
./brew-cask.sh  # Install macos applications
./git.sh        # GIT setup & aliases
./tmux.sh       # tmux & aliases
./vim.sh        # VIM with all plugins
./fish.sh       # Fish shell
./bash.sh       # Minimum Bash setup
./nvm.sh        # Nvm with multiple Node installed
./iterm.sh      # iTerm2 with custom profiles
./karabiner.sh  # Keys Remap using Karabiner
./yarn.sh       # Install yarn global dependencies
./powerline.sh  # Install powerline-go and use it in fish

cd more

./eslint.sh
./mas.sh       # Install Mac App Store applications
./awscli.sh
./shuttle.sh
```

## Thanks to
- Project that made me start: https://github.com/bdougherty/dotfiles
- Article about improvements: https://remysharp.com/2018/08/23/cli-improved
- Huge dotfiles collection: https://github.com/mathiasbynens/dotfiles
- Where i copied Karabiner stuff: https://github.com/rkalis/dotfiles

## Order
os.sh
- brew.sh
- brew-cask.sh
- macos.sh

terminal
- iterm.sh
- tmux.sh
- karabiner.sh
- fish.sh
