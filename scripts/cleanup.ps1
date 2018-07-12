$script_root = $PSScriptRoot

$local_resources = 'C:\deployment'

$start_time = Get-Date
$current_time = $start_time
Write-Host '--------------------------------'
Write-Host $current_time.ToShortTimeString() - 'CLEANING UP DEPLOYMENT TEMPS'
Write-Host '--------------------------------'
if((Test-Path $local_resources)){
    Remove-Item $local_resources -Force -Recurse
}
$current_time = Get-Date
Write-Host '--------------------------------'
Write-Host $current_time.ToShortTimeString() - 'DONE CLEANING'
Write-Host '--------------------------------'
