#!/bin/sh
alias rmb='docker run --rm -it -v "$(pwd)":/home/rust/src -v "$HOME"/.cargo/registry:/home/rust/.cargo/registry -v "$HOME"/.cargo/config:/home/rust/.cargo/config ekidd/rust-musl-builder'
