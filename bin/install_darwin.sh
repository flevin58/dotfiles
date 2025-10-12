#! /bin/sh
source $(dirname ${BASH_SOURCE[0]})/utils.sh

# Do some preliminary checks
assert_dotfiles
assert_os Darwin
assert_macports
assert_sudo

#
# Self-update
#
sudo port selfupdate

#
# Install apps
#
port_install curl
port_install eza
port_install go
port_install just
port_install neovim nvim
port_install oh-my-posh
port_install stow
port_install tree
port_install wget
port_install xz

#
# Update apps
#
sudo port upgrade outdated

#
# Install rust
#
if command -v cargo >/dev/null 2>&1;
then
		echo "rust is already installed 🦀"
else
		echo "Installing rust 🦀"
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		echo "Installing cargo addons"
		cargo install cargo-expand
		cargo install cargo-generate
		cargo install cargo-modules
fi

#
# Fonts
#
echo "Installing fonts"
rsync -a $HOME/dotfiles/fonts/ $HOME/Library/Fonts

#
# Lastly run stow to create all symlinks in $HOME
#
echo "Creating symlinks in $HOME"
stow . --dotfiles
