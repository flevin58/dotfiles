#!/usr/bin/env zsh
source ../scripts/functions.zsh

upgrade starship
symlink "starship/starship.toml" "$HOME/.config/starship.toml"
