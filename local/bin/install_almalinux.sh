#! /bin/sh
DOTFILES=${DOTFILES:-$HOME/.config/dotfiles}
UTILS=$DOTFILES/local/bin/utils.sh
if [ ! -e $UTILS ]; then
	echo "Utils not found in $UTILS"
	exit 1
fi
source $DOTFILES/Configs/zsh/.zshenv
source $UTILS

# Do some preliminary checks
assert_dotfiles
assert_os Linux
assert_network

#
# Install gum for better terminal UIs
# Note: epel-release is a prerequisite for gum
#
alma_install epel-release
alma_install gum

#
# Golang && Gum (go compiler, delve debugger and gopls language server)
#
alma_install golang-bin
gum spin --title "Installing gopls" -- go install golang.org/x/tools/gopls@latest
log_installed "gopls"
gum spin --title "Installing delve" -- go install github.com/go-delve/delve/cmd/dlv@latest
log_installed "delve"

#
# Zsh
#
alma_install zsh
gum spin --title "Setting default shell" -- sudo chsh -s /bin/zsh $USER

#
# Zsh plugin manager
#
ANTIDOTE_DIR=$HOME/.antidote
if [ ! -d $ANTIDOTE_DIR ]; then
	gum spin --title "Installing antidote" -- git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_DIR
  log_installed "antidote"
fi

#
# Update dnf
#
gum spin --title "Updating dnf" sudo dnf -y update

#
# Install core apps
#
alma_install bat
alma_install fzf
alma_install lf
alma_install curl
alma_install wget
alma_install tree
alma_install xz
alma_install z
alma_install zip

#
# Install neovim latest release (for arm64 architecture)
# Note: folders bin/, lib/, share/ will be overwritten in /usr
#
NVIM_LATEST_URL="https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-arm64.tar.gz"
sudo curl -sL $NVIM_LATEST_URL | tar xzf - -C /usr --strip-components=1
log_installed_status "neovim"

#
# Install fastfetch
#
FASTFETCH_URL="https://github.com/fastfetch-cli/fastfetch/releases/download/2.54.0/fastfetch-linux-aarch64.tar.gz"
sudo curl -sL $FASTFETCH_URL  | tar xzf - -C /usr --strip-components=2
log_installed_status "fastfetch"

#
# Install Visual Studio Code
#
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
alma_install code

#
# Install dev apps
#
alma_install nvm
alma_install just
alma_install zig

log_info "🦀 Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
log_info "🦀 Installing cargo addons"
cargo_install cargo-expand
cargo_install cargo-generate
cargo_install cargo-modules
cargo_install eza
cargo_install hyfetch

#
# Install Zig latest dev version (for arm64 architecture)
#
curl -s https://ziglang.org/builds/zig-aarch64-linux-0.16.0-dev.1204+389368392.tar.xz | tar -xf - -C $HOME/.local/bin

#
# oh-my-posh and Fira Code fonts installation
#
curl -s https://ohmyposh.dev/install.sh | bash -s
gum spin --title "Installing Fira Code Mono font" -- oh-my-posh font install FiraMono

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
# Lastly run stow to create all symlinks in $HOME
#
log_info "Creating dotfiles symlinks"
tuckr add --force \*
