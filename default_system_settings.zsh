#!/bin/zsh

print "Applying macOS user preferences..."

# Appearance, locale, text input, and general UI
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleLanguages -array "en-CA"
defaults write NSGlobalDomain AppleLocale -string "en_CA"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSGlassDiffusionSetting -int 1
defaults write NSGlobalDomain ContextMenuGesture -int 1
defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

# Dock: hidden, magnified, no pinned or recent applications
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 93
defaults write com.apple.dock tilesize -int 52
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array

# Finder
defaults write com.apple.finder AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.finder FXArrangeGroupViewBy -string "Name"
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXRemoveOldTrashItems -bool false
defaults write com.apple.finder _FXEnableColumnAutoSizing -bool true

# Desktop, windows, and widgets
defaults write com.apple.WindowManager AppWindowGroupingBehavior -int 1
defaults write com.apple.WindowManager AutoHide -bool false
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
defaults write com.apple.WindowManager HideDesktop -bool true
defaults write com.apple.WindowManager StageManagerHideWidgets -bool true
defaults write com.apple.WindowManager StandardHideWidgets -bool true

# Menu bar clock and visible Control Center items
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Battery" -bool true
defaults write com.apple.controlcenter "NSStatusItem VisibleCC BentoBox-0" -bool true
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Clock" -bool true
defaults write com.apple.controlcenter "NSStatusItem VisibleCC WiFi" -bool true
defaults write com.apple.controlcenter RemoteLiveActivitiesEnabled -bool true

# Built-in and Bluetooth trackpads
for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
  defaults write "$domain" TrackpadCornerSecondaryClick -int 2
done

# Restart affected UI services. They relaunch automatically.
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
killall ControlCenter 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

print "Done. Log out and back in for trackpad and some global settings to fully apply."
