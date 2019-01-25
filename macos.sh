# Dark mode and reduce transparency
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

###############
# Hot Corners #
###############

# Top left → Mission control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right → Application Windows
defaults write com.apple.dock wvous-tr-corner -int 3
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left → Desktop
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right → Sleep
defaults write com.apple.dock wvous-br-corner -int 10
defaults write com.apple.dock wvous-br-modifier -int 0

###############
#   Dock      #
###############

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false


# Don’t open Photos when plugging in an iPhone
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Git, use vim as editor
git config --global core.editor `which vim`

# Kill all affected apps
for app in "cfprefsd" "Dock" "Finder" "Mail" "Safari" "SystemUIServer"; do
    killall "${app}" > /dev/null 2>&1
done

