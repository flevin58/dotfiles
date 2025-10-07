# dotfiles
My dotfiles repository.
It contains all files and folders that will be symlinked in my $HOME folder.
Please note that I am using zsh 

## Prerequisites

There are some prerequisites needed to successfully install my dotfiles. 

### MacPorts

## Installation on MacOS
- Create a fork of this repo
- Download and install [MacPorts](https://www.macports.org/install.php)
- Grant yourself sudo access:
   - open a terminal
   - execute the command: sudo visudo
   - get your usename with the command: whoami
   - append this line: username        ALL = (ALL) NOPASSWD: ALL
   - save and exit
- Install the following apps:
    - sudo port install git
    - sudo port install zsh
- Clone your forked repo into $HOME:
  - cd
  - git clone https://github.com/username/dotfiles.git
- Install the other apps and symlink the dotfiles with the following command:
  - cd ~/dotfiles
  - ./bin/install_darwin.sh
  