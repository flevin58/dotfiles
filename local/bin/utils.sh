#
# Handy env vars
#
ICLOUD_DOCS="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
ERROR_EMOJI="❌"
OK_EMOJI="👍"
DOTFILES=${DOTFILES:-$HOME/.config/dotfiles}

###############################################
# Utility functions for the installation script
###############################################

#----------------------------------------------
# Logging functions
#----------------------------------------------

function log_info() {
  if command_found gum; then
    gum log -l info $1
  else
    echo "INFO $1"
  fi
}

function log_warn() {
  if command_found gum; then
    gum log -l warn $1
  else
    echo "WARN $1"
  fi
}

function log_error() {
  if command_found gum; then
    gum log -l error $1
  else
    echo "ERROR $1"
  fi
}

function log_fatal() {
  if command_found gum; then
    gum log -l fatal $1
  else
    echo "FATAL $1"
  fi
}

function log_installed() {
  if [ $? -eq 0 ]; then
    log_info "Succesfully installed $1 $OK_EMOJI"
  else
    log_error "Error installing $1 $ERROR_EMOJI"
    exit 1
  fi
}

#----------------------------------------------
# Test functions
#----------------------------------------------

# Check if a command exists
# Usage: command_found <command_name>
# Returns 0 (true) if found, 1 (false) otherwise
function command_found() {
  run_silent command -v $1
}

# Assert that we are running on the expected OS
# Usage: assert_os <Expected_OS_Name>
function assert_os() {
  os=$(uname -s)
  if [[ "$os" == "$1" ]]; then
    log_info "Operating system is $os $OK_EMOJI"
  else
    log_fatal "OOPS: $os detected, expected $1 $ERROR_EMOJI"
    exit 1
  fi
}

# Assert that network is working
# Usage: assert_network
function assert_network() {
  PROXY="proxy.golang.org"
  if run_silent nslookup $PROXY; then
    log_info "Network working as expected $OK_EMOJI"
  else
    log_fatal "Could not reach the proxy: $PROXY $ERROR_EMOJI"
    exit 1
  fi
}

# Assert that dotfiles are in the expected location
# Usage: assert_dotfiles
function assert_dotfiles() {
  # Dotfiles should be in $HOME/.config/dotfiles and the current script should be in $HOME/.config/dotfiles/bin
  script=$(realpath ${BASH_SOURCE[0]})
  if [[ "$(dirname $script)" == "$DOTFILES/local/bin" ]]; then
    log_info "Dotfiles correctly detected $OK_EMOJI"
  else
    log_fatal "the current script $script is not inside $DOTFILES!"
    exit 1
  fi
}

# Assert that Homebrew is installed
# Usage: assert_brew
function assert_brew() {
  if command_found brew; then
    log_info "Homebrew detected $OK_EMOJI"
  else
    log_fatal "Homebrew is not installed $ERROR_EMOJI"
    exit 1
  fi
}

#----------------------------------------------
# Run & Install functions
#----------------------------------------------

# Run a command silently
# Usage: run_silent <command> [args...]
function run_silent() {
  cmd=$1
  shift
  shhhh=$($cmd $@)
}

# Get the list of packages from the Configs folder
# Usage: list=$(package_list)
function package_list() {
  list=$(find $DOTFILES/Configs -type d -mindepth 1 -maxdepth 1 -exec basename {} \; | grep -v local | grep -v .git)
  echo "${list[@]}"
}

# Install a cargo package if not already installed
# Usage: cargo_install <package-name>
function cargo_install() {
  arg=$1
  cmd=${arg##*-}
  if cargo --list | grep "$cmd" &>/dev/null; then
    log_info "Already installed: $arg"
    return
  fi
  gum spin --title "Installing $arg" -- cargo install $arg
  log_installed $arg
}

# Check if a brew package is installed
# Usage: brew_installed <package-name>
function brew_installed() {
  brew list | grep $1 &>/dev/null
}

# Check if an alma package is installed
# Usage: alma_installed <package-name>
function alma_installed() {
  dnf list --installed | grep $1 &>/dev/null
}

# Install a package using alma if not already installed
# Usage: alma_install <package-name>
function alma_install() {
  app=$1
  if ! alma_installed $app; then
	  if command_found gum; then
	    gum spin --title "Installing $app" -- sudo dnf install -y $app
	  else
	    echo "Installing $app"
	    run_silent sudo dnf install -y $app
	  fi
    log_installed $app
  else
    log_info "Already installed: $app"
  fi
}

# Install a package using brew if not already installed
# Usage: brew_install <package-name>
function brew_install() {
  app=$1
  if ! brew_installed $app; then
    if command_found gum; then
      gum spin --title "Installing $app" -- brew install $app
    else
      echo "Installing $app"
      run_silent brew install $app
    fi
    log_installed $app
  else
    log_info "Already installed: $app"
  fi
}

# Remove a file, directory or symlink after logging the action
# Usage: remove <path>
function remove() {
  if [[ -d $1 ]]; then
    log_info "Deleting directory $1"
    @rm -rf "$1"
    return
  fi

  if [[ -f $1 ]]; then
    log_info "Deleting file $1"
    @rm "$1"
    return
  fi

  if [[ -L $1 ]]; then
    log_info "Unlinking $1"
    @unlink "$1"
    return
  fi

  log_error "Refusing to delete $1. Not a sym link, regular file nor folder."
}
