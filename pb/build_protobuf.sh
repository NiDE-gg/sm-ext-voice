#!/bin/bash

if [[ -d protobuf-master ]]; then
    exit 0;
fi;

# Protouf version used by CSGO
PROTOBUF_VERSION=v2.5.0

git clone https://github.com/protocolbuffers/protobuf.git -b $PROTOBUF_VERSION --recursive protobuf-master
cd protobuf-master

#sh autogen.sh
# Fix because autogen in protobuf 2.5.0 doesnt work anymore
autoreconf -f -i -Wall,no-obsolete

rm -rf autom4te.cache config.h.in~

./configure --prefix=/home/alliedmodders/sourcemod/extensions/sm-ext-voice/pb --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32" --disable-shared --enable-static
make -j 8
make install

cd ..

# Compile .proto files to c++

./bin/protoc google/protobuf/descriptor.proto --cpp_out=google/protobuf
./bin/protoc csgo/netmessages.proto --cpp_out=csgo
