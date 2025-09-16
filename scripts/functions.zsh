########################################
# Functions used by installation scripts
# Should NOT be run directly
# A script shoud include this file:
# source functions.zsh
########################################

[ -z $DOTFILES ] && export DOTFILES=$HOME/.local/share/dotfiles

symlink() {
	ln -sfv $DOTFILES/$1 $2
}

install() {
    echo "Installing $1 ..."
    brew install $1
}

upgrade() {
    echo "Upgrading $1 ..."
    brew upgrade $1
}
