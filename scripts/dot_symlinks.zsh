#!/usr/bin/env zsh

[ -z $DOTFILES ] && export DOTFILES=$HOME/.local/share/dotfiles

symlink() {
	ln -sfv $DOTFILES/$1 $2
}

symlink "starship/starship.toml" "$HOME/.config/starship.toml"
symlink "zsh/zshrc" "$HOME/.zshrc"
symlink "wezterm/dot_wezterm.lua" "$HOME/.wezterm.lua"
symlink "nvim" "$HOME/.config/nvim"
