#!/usr/bin/env zsh
source ../scripts/functions.zsh

install starship
symlink "starship/starship.toml" "$HOME/.config/starship.toml"
