# Start MetaDefender Vault Services
Write-Host "Starting MetaDefender Vault Services"
start-service vaultREST
start-service vaultProcessor
start-service vaultHelper
Write-Host "MetaDefender Vault Services Started"

# Sleep for 30 seconds
Write-Host "Sleeping for 30 seconds while services start"
Start-Sleep -seconds 30
Write-Host "Sleep time completed"

# See if we need to complete the first-run configuration
& C:\\OPSWAT\first_run.ps1 -hostname localhost -user admin -password admin -firstname Admin -lastname Admin -email admin@localhost.local

# License the instance
$activation_key = Get-Content -Path C:\OPSWAT\vault_activation.key -TotalCount 1
& C:\\OPSWAT\\activate_vault.ps1 -hostname localhost -user admin -password admin -activation_key $activation_key -activation_node_quantity 1 -activation_comment "Vault in Docker"

# Tell that we are done with initialization
Write-Host
Write-Host "*** Initialization Complete ***"
Write-Host
Write-Host "MetaDefender Vault is ready to be used"

# Loop to display logs and keep container running
$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) 
{ 
    Get-EventLog -LogName Application -Source "MetaDefender*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}