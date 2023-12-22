#!/bin/bash

mkdir -p build
rm -rf build/*

cp start.sh build/
cp README_build.md build/README.md

mkdir build/relay
cp -r relay/build-aarch64-linux-gnu build/relay/

mkdir build/optitrack_clients
cp -r optitrack_clients/build build/optitrack_clients/

cp -r setpoint_sender build

