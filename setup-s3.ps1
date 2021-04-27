# to be run locally to copy startup scripts to s3 bucket
aws s3 cp .\start_rnebular_valheim.sh s3://8dot3/valheim/start_rnebular_valheim.sh
aws s3 cp .\valheim.service s3://8dot3/valheim/valheim.service
aws s3 cp .\backup-to-s3.sh s3://8dot3/valheim/backup-to-s3.sh
aws s3 cp .\restore-from-s3.sh s3://8dot3/valheim/restore-from-s3.sh
