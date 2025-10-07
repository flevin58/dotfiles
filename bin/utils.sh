#
# Handy env vars
#
ICLOUD_DOCS="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
ERROR_EMOJI="❌"
OK_EMOJI="👍"

#
# Utility functions for the installation script
#
function assert_sudo() {
		wanted="(ALL) NOPASSWD: ALL"
		nopw=$(sudo -l | grep "$wanted")
		if [[ $nopw == "" ]];
		then
				echo "OOPS: looks like you don't have superuser powers! $ERROR_EMOJI"
				echo "Run the command 'sudo visudo' and add at the bottom the following line:"
				echo $(whoami)	ALL = $wanted
		else
				echo "Congrats you are a superuser $OK_EMOJI"
		fi
}

function assert_os() {
		os=$(uname -s)
		if [[ "$os" == "$1" ]];
		then
				echo "Operating system is $os $OK_EMOJI"
		else
				echo "OOPS: $os detected, expected $1 $ERROR_EMOJI"
				exit 1
		fi
}

function assert_dotfiles() {
		# Dotfiles should be in $HOME and the current script shoul be in $HOME/dotfiles/bin
		script=$(realpath ${BASH_SOURCE[0]})
		if [[ "$(dirname $script)" == "$HOME/dotfiles/bin" ]];
		then
				echo "Dotfiles correctly detected $OK_EMOJI"
		else
				echo "ERROR: the current script $script is not inside $HOME/dotfiles!"
				exit 1
		fi
}

function assert_macports() {
		if command -v port >/dev/null 2>&1
		then
				echo "MacPorts detected $OK_EMOJI"
		else
				echo "MacPorts is not installed $ERROR_EMOJI"
				echo "Please install it manually and rerun this script."
				echo "Follow the instructions here: https://www.macports.org/install.php"
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

		if ! command -v $app >/dev/null 2>&1
		then
				echo "Installing $name"
				sudo port install $app
		else
				echo "$name is already installed"
		fi
}

function remove() {
		if [[ -d $1 ]];
		then
				echo "Deleting directory $1"
				rm -rf "$1"
				return
		fi

		if [[ -f $1 ]];
		then
				echo "Deleting file $1"
				rm "$1"
				return
		fi

		if [[ -L $1 ]];
		then
				echo "Unlinking $1"
				unlink "$1"
				return
		fi

		echo "ERROR: refusing to delete $1. Not a sym link, regular file nor folder."
}
