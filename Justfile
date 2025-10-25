help:
  @just --list

assert:
  #!/bin/sh
  source local/bin/utils.sh
  assert_sudo
  assert_os Darwin
  assert_macports

core:
  #!/bin/sh
  source local/bin/utils.sh
  echo Installing core applications
  port_install curl
  port_install wget
  port_install eza
  port_install neovim nvim
  port_install oh-my-posh
  port_install stow
  port_install tree
  port_install xz

term:

git: assert
  #!/bin/sh
  source local/bin/utils.sh
  echo Installing up git
  test -x git || port_install git
  git config --global core.excludesFile '~/.gitignore_global'
  stow git --dotfiles

stow:
  #!/bin/sh
  source local/bin/utils.sh
  choices=$(package_list)
  chosen=$(gum choose $choices --no-limit)
  for p in $chosen; do
    $(log_info "Stowing $p")
    stow $p --dotfiles
  done
