# startup user data for ec2 instance.
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
sudo tar -xzvf steamcmd_linux.tar.gz && sudo rm -f steamcmd_linux.tar.gz

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

# Launch SteamCMD and update Valheim (gameid=896660)
sudo ./steamcmd.sh +login anonymous +force_install_dir /games/Valheim +app_update 896660 validate +quit

# copy server start script and systemctl service files from s3
cd ~
aws s3 cp s3://8dot3/valheim . --recursive
sudo chmod +x valheim.service
sudo chmod +x *.sh
sudo cp start_rnebular_valheim.sh /games/Valheim

# copy service file into systemd and start Service
sudo cp valheim.service /etc/systemd/system
#sudo systemctl start valheim
