#!/usr/bin/env zsh
source ../scripts/functions.zsh

install wezterm
symlink "wezterm/dot_wezterm.lua" "$HOME/.wezterm.lua"
