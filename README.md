# Indiflight groundstation & racebian configuration

This repo contains utilities for a laptop ground station to:
- send optitrack data to a Raspberry Pi Zero 2W companion computer running [Racebian](github.com/tblaha/Racebian)
- send position setpoints in the same fashion
- overwrite a local folder with logs from the flight controller

Furthermore it contains Racebain companion computer programs and/or configurations to
- relay position information and setpoints to an Indiflight flight controller
- flash binaries over-the-air via USB of SWD between companion and flight controller
- configure the flight controller over-the-air via USB

Future work:
- eliminate the need for companion computer altogether by sending position/setpoint via bluetooth from the betaflight configurator


## Use the binary packages on Ubuntu 22.04

Download a release from `https://github.com/tudelft/indiflightGroundstation/releases`, extract and open a terminal in the root folder. Then perform the steps below

### Setup

Install prerequisites on your local machine

    sudo apt install libboost-program-options1.74.0 libboost-filesystem1.74.0 tmux python3 rsync sshpass

Push relay program onto the companion computer (must be on the same wifi):

    rsync -rRlp relay/build-aarch64-linux-gnu pi@10.0.0.1:"/home/pi"

Enable the service to automatically start the relay on boot of the companion computer (optional, otherwise you need to make sure to program is run manually)

    pi@10.0.0.1 $  sudo install -m 644 /home/pi/relay/build-aarch64-linux-gnu/relay.service /lib/systemd/system/relay.service
    pi@10.0.0.1 $  sudo systemctl daemon-reload
    pi@10.0.0.1 $  sudo systemctl enable relay.service
    pi@10.0.0.1 $  sudo systemctl start relay.service

Enable the `usb2net` service to access the usb port in serial mode over TCP.

    pi@10.0.0.1 $  sudo systemctl enable ser2net.service
    pi@10.0.0.1 $  sudo systemctl start ser2net.service

### Usage

#### Flight operation with optitrack:

    ./start.sh <motive_rigid_body_id>

- top left: See optitrack position stream
- top right: Check that the relay service is running on the companion computer
- bottom left: send setpoints
- bottom right: check ping with the companion computer


#### Download logs

    ./log_downloader/get_logs.sh [-r] /dev/sda1 ./logfilesMIRROR

**WARNING. This will SYNCHRONIZE the contents of the SD card into ./logfilesMIRROR EXACTLY. This means that if the SD is empty or some logfiles have been corrupted, then `logfilesMIRROR` will also be empty or corrupted. My recommendation is to rename and move the relevant logs elsewhere immediately.**

The "`-r`" flag attempts to reset the flight controller (only possible if SWD is connected) after the transfer.


### Troubleshooting

- The flag "`--test`" can be passed to `start.sh` to stream constant but nonzero positions to debug connection issues.
- you may need to do a `chmod +x start.sh` or `chmod +x get_logs.sh` before first run


## Build the package from source

Clone with git. Then perform prerequisites:
```sh
sudo apt install libboost-all-dev build-essentials cmake
git submodule update --init --recursive
```

Build into a folder called `build` (will be overwritted every time)
```sh
./make_release.sh
```
