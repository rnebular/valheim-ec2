# quick startup script for Valheim server
$date = Get-Date
Write-Host "$date - Starting Valhiem instance..."
aws ec2 start-instances --instance-ids i-079dbf837d3ea8d70
