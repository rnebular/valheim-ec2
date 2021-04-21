# valheim-ec2
Using EC2 to run Valheim Dedicated Server

I did all of this as the `ec2-user` user on a fresh Amazon Linux 2 instance. I followed along with this guide mostly:
https://gameplay.tips/guides/9765-valheim.html

Next mission, see if I can make this run as a container :)
https://github.com/lloesche/valheim-server-docker

## "user data" scripting (basically stuff to run on fresh instance):
- init.sh

## edit start_rnebular_valheim.sh if needed
- start_rnebular_valheim.sh

## copy service to systemctl
sudo cp valheim.service /etc/systemd/system
sudo systemctl start valheim

## wait 15 seconds, then check status
sudo systemctl status valheim


### If using an extra volume
Format and mount game storage drive, if using another volume for storage Your device name might be something other than /dev/xvdb, so edit the lines accordingly:

mkfs.ext4 /dev/xvdb
echo "/dev/xvdb   /opt/games  ext4    defaults,noatime  1   1" >>/etc/fstab
mount /opt/games
