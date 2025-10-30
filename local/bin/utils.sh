#
# Handy env vars
#
ICLOUD_DOCS="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
ERROR_EMOJI="❌"
OK_EMOJI="👍"
DOTFILES=$HOME/.dotfiles

#
# Utility functions for the installation script
#

function run_silent() {
  cmd=$1
  shift
  shhhh=$($cmd $@)
}

function command_found() {
  run_silent command -v $1
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
    log_info "Operating system is $os $OK_EMOJI"
  else
    log_fatal "OOPS: $os detected, expected $1 $ERROR_EMOJI"
    exit 1
  fi
}

function assert_dotfiles() {
  # Dotfiles should be in $HOME and the current script shoul be in $HOME/dotfiles/bin
  script=$(realpath ${BASH_SOURCE[0]})
  if [[ "$(dirname $script)" == "$HOME/.dotfiles/local/bin" ]]; then
    log_info "Dotfiles correctly detected $OK_EMOJI"
  else
    log_fatal "the current script $script is not inside $HOME/dotfiles!"
    exit 1
  fi
}

function assert_brew() {
  if command_found brew; then
    log_info "Homebrew detected $OK_EMOJI"
  else
    log_fatal "Homebrew is not installed $ERROR_EMOJI"
    exit 1
  fi
}

function cargo_install() {
  arg=$1
  cmd=${arg##*-}
  if cargo --list | grep "$cmd" &>/dev/null; then
    log_info "Already installed: $arg"
    return
  fi
  gum spin --title "Installing $arg" -- cargo install $arg
  if [ $? -eq 0 ]; then
    log_info "Succesfully installed $arg $OK_EMOJI"
  else
    log_error "Error installing $arg $ERROR_EMOJI"
  fi
}

function brew_installed() {
  brew list | grep $1 &>/dev/null
}

function alma_installed() {
  dnf list --installed | grep $1 &>/dev/null
}

function alma_install() {
  app=$1
  if ! alma_installed $app; then
	  if command_found gum; then
	    gum spin --title "Installing $app" -- brew install $app
	  else
	    echo "Installing $app"
	    run_silent sudo dnf install -y $app
	  fi
  else
    log_info "Already installed: $app"
  fi
}

function brew_install() {
  app=$1
  if ! brew_installed $app; then
    if command_found gum; then
      gum spin --title "Installing $app" -- brew install $app
    else
      echo "Installing $app"
      run_silent brew install $app
    fi
    if [ $? -eq 0 ]; then
      log_info "Succesfully installed $app $OK_EMOJI"
    else
      log_error "Error installing $app $ERROR_EMOJI"
    fi
  else
    log_info "Already installed: $app"
  fi
}

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
