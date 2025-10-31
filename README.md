# dotfiles

My dotfiles repository.
It contains all files and folders that will be installed / symlinked in my
$HOME folder.
Please note that I am using zsh

## Prerequisites

There are some core programs needed to successfully install my dotfiles:

- curl (used to download the initial setup script)
- git (used to clone this repo and subsequently update it)
- homebrew (used to install commands and applications)

## Installation on MacOS

- Create a fork of this repo
- Install [Homebrew](https://brew.sh)
- Grant yourself sudo access:
  - open a terminal
  - execute the command: sudo visudo
  - get your usename with the command: whoami
  - append this line: username ALL = (ALL) NOPASSWD: ALL
  - save and exit
- Install the following apps:
  - brew install git
  - brew install zsh
- Clone your forked repo into $HOME/.dotfiles:
  - cd
  - git clone https://github.com/username/dotfiles.git ~/.dotfiles
- Install the other apps and symlink the dotfiles with the following command:
  - cd ~/dotfiles
  - ./bin/install_darwin.sh

  ## Installation on AlmaLinux
  - Grant sudo access: 
    - make the user member of the 'wheel' group
    - edit sudoers file by making 'wheel' group access with NOPASSWD
  - Install zsh:
    > sudo dnf install -y zsh
  - Install antidote plugin manager:
    > git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
  - Change default shell to zsh:
    > chsh -s /bin/zsh $USER
  - Install git:
    > sudo dnf install -y git-core
  - Install oh-my-posh:
    > curl -s https://ohmyposh.dev/install.sh | bash -s
  - Install Firacode Mono font:
    > oh-my-posh font install (choose 'FiraMono')
  - Install rust:
    > curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  - Install golang:
    > sudo dnf install -y golang
  - Add golang utils path to .zshenv:
    > export PATH=$PATH:~/go/bin
  - Install gum:
    > go install github.com/charmbracelet/gum@latest

