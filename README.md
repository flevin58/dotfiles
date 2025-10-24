# dotfiles
My dotfiles repository.
It contains all files and folders that will be installed / symlinked in my $HOME folder.
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
   - append this line: username        ALL = (ALL) NOPASSWD: ALL
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
  
