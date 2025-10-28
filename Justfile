help:
  @just --list

assert:
  #!/bin/sh
  source local/bin/utils.sh
  assert_dotfiles
  assert_os Darwin
  assert_brew

core:
  #!/bin/sh
  source local/bin/utils.sh
  log_info "Installing core applications"
  brew_install curl
  brew_install wget
  brew_install eza
  brew_install neovim nvim
  brew_install oh-my-posh
  brew_install stow
  brew_install tree
  brew_install xz

git: assert
  #!/bin/sh
  source local/bin/utils.sh
  echo Installing up git
  test -x git || port_install git
  git config --global core.excludesFile '~/.gitignore_global'
  stow git --dotfiles

run:
  #!/bin/sh
  source local/bin/utils.sh
  run_silent ls -a -l ~/Documents

stow:
  #!/bin/sh
  source local/bin/utils.sh
  choices=$(package_list)
  chosen=$(gum choose $choices --no-limit)
  for p in $chosen; do
    $(log_info "Stowing $p")
    stow $p --dotfiles
  done
