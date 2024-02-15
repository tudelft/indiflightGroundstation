if you want make changes: do it in src/relay.cpp

to build:
mkdir build
cmake ..
make

start connection:
sudo ./relay

## Optional: unit file

A systemd unit file is provided so systemd can manage that the client is always running, even after reboot.

Install, enable and run on the pi:
```shell
sudo install -m 644 /home/pi/relay/build-aarch64-linux-gnu/relay-connect.service /lib/systemd/system/relay-connect.service
sudo systemctl daemon-reload
sudo systemctl enable relay.service
sudo systemctl start relay.service
```
