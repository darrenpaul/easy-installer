$script_root = $PSScriptRoot

$software = "ATOM"

$local_resources = 'C:\deployment'

$url = "https://atom-installer.github.com/v1.24.0/AtomSetup-x64.exe?s=1518059204&ext=.exe"
$output = "C:\deployment\atom.exe"
$command = "/passive"

$start_time = Get-Date
$current_time = $start_time
Write-Host '--------------------------------'
Write-Host $current_time.ToShortTimeString() - 'MAKING TEMP DIRECTORY'
Write-Host '--------------------------------'
if(!(Test-Path $local_resources)){
    New-Item -ItemType directory -Path $local_resources
}
$current_time = Get-Date
Write-Host '--------------------------------'
Write-Host $current_time.ToShortTimeString() - 'DONE MAKING DIRECTORY'
Write-Host '--------------------------------'

$current_time = Get-Date
Write-Host '--------------------------------'
Write-Host $current_time.ToShortTimeString() - 'DOWNLOADING', $software
Write-Host '--------------------------------'
if(!(Test-Path $output)){
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($url, $output)
    $current_time = Get-Date
}
Write-Host '--------------------------------'
Write-Host $current_time.ToShortTimeString() - 'DOWNLOAD FINISHED'
Write-Host '--------------------------------'
$current_time = Get-Date
Write-Host '--------------------------------'
Write-Host $current_time.ToShortTimeString() - 'INSTALLING', $software
Write-Host '--------------------------------'
Start-Process -FilePath $output /Silent
$current_time = Get-Date
