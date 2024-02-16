#!/bin/bash

mkdir -p build
rm -rf build/*

# simple programs
cp start.sh build/
cp setpointSender.py build
cp README.md build/README.md
cp -r log_downloader build/

# relay
# to build with the pi-cross cross compiler, see Racebian readme
mkdir build/relay
rm -rf relay/build-aarch64-linux-gnu

cd relay
    docker run -v rootfs:/rootfs --mount type=bind,src=./,dst=/package pi-cross --processes=30 --clean-build
cd ..

cp -r relay/build-* build/relay/

# optitrack clients
mkdir -p optitrack_clients/build
rm -rf optitrack_clients/build/*
cd optitrack_clients/build/
cmake -D'CLIENTS=udp;console' .. && make
cd ../..
cp -r optitrack_clients/build build/optitrack_clients/


zip -r indiflight-groundstation.zip build
