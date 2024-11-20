#!/bin/zsh

echo .DS_Store >> ~/.gitignore_global

git config --global --add user.name flevin58
git config --global --add user.email flevin58@gmail.com
git config --global --add core.excludesfile /Users/flevin58/.gitignore_global
