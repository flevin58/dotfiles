#
# Handy env vars
#
ICLOUD_DOCS="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
ERROR_EMOJI="❌"
OK_EMOJI="👍"

#
# Utility functions for the installation script
#
function command_found() {
  command -v $1 >/dev/null 2>&1
}

function package_list() {
  list=$(find $DOTFILES -type d -mindepth 1 -maxdepth 1 -exec basename {} \; | grep -v local | grep -v .git)
  echo "${list[@]}"
}

function log_info() {
  if command_found gum; then
    gum log -l info $1
  else
    echo "INFO: $1"
  fi
}

function log_warn() {
  if command_found gum; then
    gum log -l warn $1
  else
    echo "WARN: $1"
  fi
}

function log_error() {
  if command_found gum; then
    gum log -l error $1
  else
    echo "ERROR: $1"
  fi
}

function log_fatal() {
  if command_found gum; then
    gum log -l fatal $1
  else
    echo "FATAL: $1"
  fi
}

function assert_os() {
  os=$(uname -s)
  if [[ "$os" == "$1" ]]; then
    echo "Operating system is $os $OK_EMOJI"
  else
    echo "OOPS: $os detected, expected $1 $ERROR_EMOJI"
    exit 1
  fi
}

function assert_dotfiles() {
  # Dotfiles should be in $HOME and the current script shoul be in $HOME/dotfiles/bin
  script=$(realpath ${BASH_SOURCE[0]})
  if [[ "$(dirname $script)" == "$HOME/.dotfiles/local/bin" ]]; then
    echo "Dotfiles correctly detected $OK_EMOJI"
  else
    echo "ERROR: the current script $script is not inside $HOME/dotfiles!"
    exit 1
  fi
}

function assert_brew() {
  if command_found brew; then
    echo "Homebrew detected $OK_EMOJI"
  else
    echo "Homebrew is not installed $ERROR_EMOJI"
    echo "Please install it manually and rerun this script."
    echo "Follow the instructions here: https://brew.sh"
    exit 1
  fi
}

function port_install() {
  if [ -z $2 ]; then
    name=$1
    app=$1
  else
    name=$1
    app=$2
  fi

  if ! command_found $app; then
    echo "Installing $name"
    sudo port install $app
  else
    echo "$name is already installed"
  fi
}

function brew_install() {
  if [ -z $2 ]; then
    name=$1
    app=$1
  else
    name=$1
    app=$2
  fi

  if ! command_found $app; then
    echo "Installing $name"
    brew install $app
  else
    echo "$name is already installed"
  fi
}

function remove() {
  if [[ -d $1 ]]; then
    echo "Deleting directory $1"
    rm -rf "$1"
    return
  fi

  if [[ -f $1 ]]; then
    echo "Deleting file $1"
    rm "$1"
    return
  fi

  if [[ -L $1 ]]; then
    echo "Unlinking $1"
    unlink "$1"
    return
  fi

  echo "ERROR: refusing to delete $1. Not a sym link, regular file nor folder."
}
