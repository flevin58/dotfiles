#!/usr/bin/env zsh

export DOTFILES=~/.local/share/dotfiles

symlink() {
	[ -f $2 ] && rm $2
	ln -s $DOTFILES/$1 $2
}

symlink "starship/starship.toml" "$HOME/.config/starship.toml"
symlink "zsh/zshrc" "$HOME/.zshrc"
symlink "kitty" "$HOME/.config/kitty"

