#!/bin/sh
dir="$(dirname -- "$0")"
if [ $dir == "." ]; then
    rmb_path="$(pwd)"/_rmb.sh
else
    rmb_path="$(pwd)"/"$dir"/_rmb.sh
fi
source $rmb_path
target=x86_64-unknown-linux-musl
if [ $# -gt 0 ] && [ $1 == "linux" ];then
    target=x86_64-unknown-linux-gnu
fi
rmb cargo build --target=$target --release
