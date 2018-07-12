$script_root = $PSScriptRoot

$software = "VLC 3.0.0"

$local_resources = 'C:\deployment'

$url = "http://videolan.mirror.liquidtelecom.com/vlc/3.0.0/win32/vlc-3.0.0-win32.exe"
$output = "C:\deployment\firefox.exe"
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
Start-Process -FilePath $output /S -Wait
$current_time = Get-Date
