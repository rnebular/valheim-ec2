# simple script to wait for 5 minutes and then shut down the Valheim server.
Start-Sleep 300

Write-Host "Shutting down Valhiem instance..."
aws ec2 stop-instances --instance-ids i-079dbf837d3ea8d70
