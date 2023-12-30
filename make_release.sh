#!/bin/bash

mkdir -p racebian-groundstation
rm -rf racebian-groundstation/*

cp start.sh racebian-groundstation/
cp README_build.md racebian-groundstation/README.md

mkdir racebian-groundstation/relay
cp -r relay/build-aarch64-linux-gnu racebian-groundstation/relay/

mkdir racebian-groundstation/optitrack_clients
cp -r optitrack_clients/build racebian-groundstation/optitrack_clients/

cp -r setpoint_sender racebian-groundstation

zip -r racebian-groundstation.zip racebian-groundstation
