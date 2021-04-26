# to be run locally to copy startup scripts to s3 bucket
aws s3 cp .\start_rnebular_valheim.sh s3://8dot3/valheim/start_rnebular_valheim.sh
aws s3 cp .\valheim.service s3://8dot3/valheim/valheim.service
