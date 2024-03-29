#!/bin/bash

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    echo "I'm sorry but there's no much to uninstall here"
    exit
fi

###############################################################################
# Global                                                                      #
###############################################################################
echo "Configuring Global stuff"

# Dark modeD and reduce transparency
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

###############################################################################
# Hot Corners                                                                 #
###############################################################################
echo "Configuring Hot Corners"

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

###############################################################################
# Dock                                                                        #
###############################################################################
echo "Configuring Dock"

# Keep the dock always visible (no hide and show)
defaults write com.apple.dock autohide -bool false


defaults delete com.apple.dock persistent-apps

dock_item() {
    printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>', "$1"
}

defaults write com.apple.dock persistent-apps -array \
    "$(dock_item /Applications/1Password.app)" \
    "$(dock_item /Applications/Microsoft\ Outlook.app)" \
    "$(dock_item /Applications/Discord.app)" \
    "$(dock_item /System/Applications/Calendar.app)" \
    "$(dock_item /Applications/Google\ Chrome.app)" \
    "$(dock_item /Applications/Google\ Chrome\ Canary.app)" \
    "$(dock_item /Applications/Firefox.app)" \
    "$(dock_item /Applications/Firefox\ Developer\ Edition.app)" \
    "$(dock_item /Applications/Firefox\ Nightly.app)" \
    "$(dock_item /Applications/Opera.app)" \
    "$(dock_item /Applications/Microsoft\ Edge.app)" \
    "$(dock_item /Applications/Safari.app)" \
    "$(dock_item /Applications/Slack.app)" \
    "$(dock_item /Applications/Microsoft\ Teams.app)" \
    "$(dock_item /System/Applications/Notes.app)" \
    "$(dock_item /Applications/iTerm.app)" \
    "$(dock_item /Applications/Visual\ Studio\ Code.app)" \
    "$(dock_item /Applications/Notion.app)" \
    "$(dock_item /System/Applications/App\ Store.app)" \
    "$(dock_item /System/Applications/System\ Preferences.app)" \
    "$(dock_item /Applications/MacDown.app)" \
    "$(dock_item /Applications/Postman.app)" \
    "$(dock_item /Applications/TIDAL.app)" \
    "$(dock_item /Applications/Sketch.app)" \
    "$(dock_item /Applications/Deckset.app)" \
    "$(dock_item /System/Library/CoreServices/Applications/Screen\ Sharing.app)" \
    "$(dock_item /System/Applications/Utilities/Screenshot.app)"

# killall Dock


###############################################################################
# Trackpad & keyboard          §                                               #
###############################################################################
echo "Configuring Trackpad & Keyboard"

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Enable full keyboard access for all controls  (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

###############################################################################
# Finder                                                                      #
###############################################################################
echo "Configuring Finder"

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

###############################################################################
# Bluetooth                                                                   #
###############################################################################
echo "Configuring Bluetooth"

# Enable Bluetooth AptX codec
sudo defaults write bluetoothaudiod "Enable AptX codec" -bool true


###############################################################################
# Photos                                                                      #
###############################################################################
echo "Configuring Photos"

# Don’t open Photos when plugging in an iPhone
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES

###############################################################################
# Menu Bar                                                                    #
###############################################################################
echo "Configuring Menu Bar"


# Show Battery Percentage on the meny bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Show volume in menu bar and hide clock/calendar (I use day-o)
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu"
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm"


###############################################################################

echo "Killing all affected apps to apply the changes"

# Kill all affected apps
for app in "cfprefsd" "Dock" "Finder" "Mail" "Safari" "SystemUIServer"; do
    killall "${app}" > /dev/null 2>&1
done
