#!/usr/bin/env zsh

brew install wezterm
brew install starship
brew install --cask vscodium

echo "installing rust 🦀"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
