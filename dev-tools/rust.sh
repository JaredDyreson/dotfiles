#!/usr/bin/env bash

# Install Rust and other toolchains
sudo pacman -Sy --noconfirm curl ripgrep
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
cargo install cargo-deny cargo-zigbuild cargo-about cargo-expand
rustup toolchain install aarch64-unknown-linux-gnu
