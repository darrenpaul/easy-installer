$script_root = $PSScriptRoot

$software = "NVIDIA"

$local_resources = 'C:\deployment'

$url = "http://uk.download.nvidia.com/Windows/397.64/397.64-desktop-win10-64bit-international-whql.exe"
$output = "C:\deployment\nvidia.exe"

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
Start-Process -FilePath $output "/n /s /noeula /nofinish" -Wait
$current_time = Get-Date
