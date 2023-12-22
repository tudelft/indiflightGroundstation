# racebian ground station utilities

## Build the new optitrack client

prerequisites
```sh
sudo apt install libboost-all-dev tmux
```

If you just cloned
```sh
git submodule update --init --recursive
```

Otherwise
```sh
git submodule update --recursive
```

Then:
```sh
cd ext/optitrack_clients
mkdir build && cd build
cmake -D'CLIENTS=udp;debug" .. && make
```
