#! /bin/sh
source $DOTFILES/local/bin/utils.sh

# Do some preliminary checks
assert_dotfiles
assert_os Darwin
assert_brew

#
# Update brew
#
gum spin --title "Updating brew" brew update

#
# Install gum for better messages!
#
brew_install gum

#
# Install core apps
#
brew_install antidote
brew_install bat
brew_install fzf
brew_install lf
brew_install zoxide
brew_install neofetch
brew_install curl
brew_install wget
brew_install eza
brew_install neovim
brew_install oh-my-posh
brew_install stow
brew_install tree
brew_install xz
brew_install z
brew_install zip
#
# Install dev apps
#
brew_install nvm
brew_install just
brew_install go
brew_install zig
log_info "🦀 Installing rust"
brew_install rust
brew_install rustup
log_info "🦀 Installing cargo addons"
cargo_install cargo-expand
cargo_install cargo-generate
cargo_install cargo-modules

#
# Update apps
#
gum spin --title "Upgrading brew" -- brew upgrade

# Install NodeJS via nvm (needed by neovim's treesitter)
if command_found node; then
  log_info "Already installed: NodeJS"
else
  gum spin --title "Installing NodeJS" -- nvm install node
fi

#
# Bat theme configuration
# The env var BAT_THEME is set in ~/.zshenv to "Catppuccin Mocha"
#
themedir="$(bat --config-dir)/themes"
if ls "$themedir" | grep Catppuccin &>/dev/null; then
  log_info "Already installed: Catppuccin bat theme"
else
  log_info "Installing bat theme: Catppuccin bat theme"
  run_silent mkdir -p "$(bat --config-dir)/themes"
  wget -q -P "$themedir" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
  wget -q -P "$themedir" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
  wget -q -P "$themedir" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
  wget -q -P "$themedir" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
  run_silent bat cache --build
fi

#
# Fonts
#
log_info "Installing fonts"
gum spin -- rsync -a $DOTFILES/local/fonts/ $HOME/Library/Fonts

#
# Lastly run stow to create all symlinks in $HOME
#
log_info "Creating symlinks in $HOME"
dirlist=$(find $DOTFILES -type d -mindepth 1 -maxdepth 1 -exec basename {} \; | grep -v local | grep -v .git)
for d in $dirlist; do
  stow $d --dotfiles
done
