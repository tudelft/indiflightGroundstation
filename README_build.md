# racebian ground station utilities -- build

Prerequisistes
```sh
sudo apt install tmux rsync libboost-filesystem1.74.0 libboost-program-options1.74.0
```

Installation on the raspberry pi. Connect to the pi wifi first, then copy the binaries of the relay onto the pi, for instance with rsync:
```sh
rsync -rRlp -e "/usr/bin/sshpass -p pi ssh -o StrictHostKeyChecking=no -l pi" relay/build-aarch64-linux-gnu pi@10.0.0.1:"/home/pi/"
```

Start:
```sh
./start.sh <RIGID_BODY_ID> [--test]
```
