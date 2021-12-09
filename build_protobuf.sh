#!/bin/bash

if [[ -d protobuf ]]; then
    exit 0;
fi;

git clone https://github.com/protocolbuffers/protobuf.git --recursive
cd protobuf
sh autogen.sh
./configure --prefix=/home/alliedmodders/sourcemod/extensions/sm-ext-voice/protobuf_compiled --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32" --disable-shared --enable-static
make -j 8
make install
