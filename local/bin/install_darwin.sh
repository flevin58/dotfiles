#! /bin/sh
source $(dirname ${BASH_SOURCE[0]})/utils.sh

# Do some preliminary checks
assert_dotfiles
assert_os Darwin
assert_brew
assert_sudo

# Install nvm (NodeJS needed by neovim's treesitter)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

#
# Self-update
#
brew update

#
# Install core apps
#
brew_install antidote
brew_install fzf
brew_install zoxide
brew_install neofetch
brew_install curl
brew_install wget
brew_install eza
brew_install neovim nvim
brew_install oh-my-posh
brew_install stow
brew_install tree
brew_install xz
brew_install z
brew_install nvm
#
# Install dev apps
#
brew_install just
brew_install go
brew_install zig
echo "🦀 Installing rust"
brew_install rust
brew_install rustup
echo "🦀 Installing cargo addons"
cargo install cargo-expand
cargo install cargo-generate
cargo install cargo-modules

#
# Update apps
#
brew upgrade

#
# Fonts
#
echo "Installing fonts"
rsync -a $DOTFILES/local/fonts/ $HOME/Library/Fonts

#
# Lastly run stow to create all symlinks in $HOME
#
echo "Creating symlinks in $HOME"
dirlist=$(find $DOTFILES -type d -mindepth 1 -maxdepth 1 -exec basename {} \; | grep -v local | grep -v .git)
for d in $dirlist; do
  stow $d --dotfiles
done
