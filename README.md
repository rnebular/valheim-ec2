# valheim-ec2
Using EC2 to run Valheim Dedicated Server

I did all of this as the `ec2-user` user on a fresh Amazon Linux 2 instance. I followed along with this guide mostly:
https://gameplay.tips/guides/9765-valheim.html

Next mission, see if I can make this run as a container :)

## "user data" scripting (basically stuff to run on fresh instance):
```
sudo yum update -y

# Install SteamCMD pre-reqs
sudo yum install -y glibc.i686 libstdc++48.i686

# create location for games
sudo mkdir /games
sudo mkdir /games/Valheim

# Create SteamCMD directory
sudo mkdir ~/steamcmd && cd ~/steamcmd

# Download SteamCMD
sudo wget 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz'

# Unpack SteamCMD
sudo tar -xzvf steamcmd_linux.tar.gz && rm -f steamcmd_linux.tar.gz

# Launch SteamCMD and update Valheim (gameid=896660)
sudo ./steamcmd.sh +login anonymous +force_install_dir /games/Valheim +app_update 896660 validate +quit

# update the startup files
sudo cp /games/Valheim/start_server.sh /games/Valheim/start_rnebular_valheim.sh
```

## edit start_rnebular_valheim.sh with stuff below:
vi /games/Valheim/start_rnebular_valheim.sh

```
#!/bin/bash

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.

# update the server if needed
./home/ec2-user/steamcmd/steamcmd.sh +login anonymous +force_install_dir /games/Valheim +app_update 896660 +quit

# start the game
./valheim_server.x86_64 -name "RNebular Valheim" -port 2456 -world "Dedicated" -password "<password_here>" > /dev/null &

export LD_LIBRARY_PATH=$templdpath

echo "Server started"
echo ""
#read -p "Press RETURN to stop server"
#echo 1 > server_exit.drp

#echo "Server exit signal set"
#echo "You can now close this terminal"

while :
do
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "valheim.service: timestamp ${TIMESTAMP}"
sleep 60
done
```

## setup service and copy to systemd
sudo vi valheim.service
```
[Unit]
Description=Valheim service
Wants=network.target
After=syslog.target network-online.target

[Service]
Type=simple
Restart=on-failure
RestartSec=10
User=ec2-user
WorkingDirectory=/games/Valheim
ExecStart=/games/Valheim/start_rnebular_valheim.sh

[Install]
WantedBy=multi-user.target
```

sudo cp valheim.service /etc/systemd/system
sudo systemctl start valheim

## wait 15 seconds, then check status
sudo systemctl status valheim


(if using an extra volume)
# Format and mount game storage drive, if using another volume for storage
# Your device name might be something other than /dev/xvdb, so edit the lines
# accordingly
mkfs.ext4 /dev/xvdb
echo "/dev/xvdb   /opt/games  ext4    defaults,noatime  1   1" >>/etc/fstab
mount /opt/games
