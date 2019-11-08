#!/bin/sh
name=`grep "name" Cargo.toml|awk '{print $3}'|sed 's/"//g'`
target=x86_64-unknown-linux-musl
if [ $# -gt 0 ] && [ $1 == "linux" ];then
    target=x86_64-unknown-linux-gnu
fi

docker run --rm -t -v $(pwd)/target/$target/release/:/home/rust/src ekidd/rust-musl-builder strip $name
