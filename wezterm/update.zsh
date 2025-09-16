#!/usr/bin/env zsh
source ../scripts/functions.zsh

upgrade wezterm
symlink "wezterm/dot_wezterm.lua" "$HOME/.wezterm.lua"
