#!/bin/bash
set -e

## mute startup sound
sudo nvram SystemAudioVolume=" "

## not sleep
sudo systemsetup -setcomputersleep Off > /dev/null

## present only opened app on dock
defaults write com.apple.dock static-only -bool true

## remove all app of dock
defaults write com.apple.dock persistent-apps -array

## present dotfiles
defaults write com.apple.finder AppleShowAllFiles -bool true

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

## skip disk verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes
