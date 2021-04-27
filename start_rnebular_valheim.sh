#!/bin/bash

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

# update the server if needed
# sudo /home/ec2-user/steamcmd/steamcmd.sh +login anonymous +force_install_dir /games/Valheim +app_update 896660 +quit

# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.
./valheim_server.x86_64 -name "RNebular Valheim" -port 2456 -world "Dedicated" -password "<password>" > /dev/null &

export LD_LIBRARY_PATH=$templdpath

echo "Server started"
echo ""

while :
do
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "valheim.service: timestamp ${TIMESTAMP}"
sleep 60
done
