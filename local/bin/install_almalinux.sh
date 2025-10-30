#! /bin/sh
UTILS=$HOME/.dotfiles/local/bin/utils.sh
if [ ! -e $UTILS ]; then
	echo "Utils not found in $UTILS"
	exit 1
fi
source $UTILS

# Do some preliminary checks
assert_dotfiles
assert_os Linux

#
# Install gum for better messages!
#
echo "Installing prerequisites: go and gum"
alma_install -y go
run_silent go install github.com/charmbracelet/gum@latest

#
# Update dnf
#
gum spin --title "Updating dnf" sudo dnf update

#
# Install core apps
#
alma_install antidote
alma_install bat
alma_install fzf
alma_install lf
alma_install zoxide
alma_install neofetch
alma_install curl
alma_install wget
alma_install eza
alma_install neovim
alma_install oh-my-posh
alma_install stow
alma_install tree
alma_install xz
alma_install z
alma_install zip
#
# Install dev apps
#
alma_install nvm
alma_install just
alma_install zig
exit 0
log_info "🦀 Installing rust"
alma_install rust
alma_install rustup
log_info "🦀 Installing cargo addons"
cargo_install cargo-expand
cargo_install cargo-generate
cargo_install cargo-modules
#
# Golang (go compiler, delve debugger and gopls language server)
#
alma_install go
gum spin --title "Installing gopls" -- go install golang.org/x/tools/gopls@latest
gum spin --title "Installing delve" -- go install github.com/go-delve/delve/cmd/dlv@latest

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
gum spin -- rsync -a $HOME/.dotfiles/local/fonts/ $HOME/Library/Fonts

#
# Lastly run stow to create all symlinks in $HOME
#
log_info "Creating symlinks in $HOME"
stow -R home --dotfiles
