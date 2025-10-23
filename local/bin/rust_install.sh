#!/usr/bin/env zsh
echo "Installing rust 🦀"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installing cargo addons"
cargo install cargo-expand
cargo install cargo-generate
cargo install cargo-modules
