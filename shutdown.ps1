# simple script to wait for 5 minutes and then shut down the Valheim server.
$date = Get-Date
Write-Host "$date - Waiting for 20 minutes to fully wait for auto-save, then shut down the server."
Start-Sleep 1200

$date = Get-Date
Write-Host "$date - Shutting down Valhiem instance..."
aws ec2 stop-instances --instance-ids i-079dbf837d3ea8d70
