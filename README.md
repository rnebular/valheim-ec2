# valheim-ec2
Using EC2 to run Valheim Dedicated Server

I did all of this as the `ec2-user` user on a fresh Amazon Linux 2 instance. I followed along with this guide mostly:
https://gameplay.tips/guides/9765-valheim.html

- NOTE: Add the `EC2-S3ReadOnly` IAM role to the instance. This is an IAM role I built in my account previously.

Next mission, see if I can make this run as a container :)
https://github.com/lloesche/valheim-server-docker

## "user data" scripting (basically stuff to run on fresh instance):
- init.sh

## edit start_rnebular_valheim.sh if needed (change password), upload to s3 (run script locally)
- setup-s3.ps1

### Worlds Backups - Need to make this work and test
- Create backups of worlds folder on schedule (dest folder ~/valheim-backups/worlds)
- Copy world backups to s3


## NOTE TO SELF: DON'T AUTHOR BASH SCRIPTS ON WINDOWS AND EXPECT AWESOMENESS


### If using an extra volume
Format and mount game storage drive, if using another volume for storage Your device name might be something other than /dev/xvdb, so edit the lines accordingly:

mkfs.ext4 /dev/xvdb
echo "/dev/xvdb   /opt/games  ext4    defaults,noatime  1   1" >>/etc/fstab
mount /opt/games
