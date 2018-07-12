$script_root = $PSScriptRoot

$local_resources = 'C:\deployment'

$software = "DaVinci Resolve 14.3"

$source = "\\fileserver01\resources\it\software\DaVinci Resolve\14.3\DaVinci_Resolve_14.3_Windows.exe"
$destination = "C:\deployment\DaVinci_Resolve_14.3_Windows.exe"

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
Write-Host $current_time.ToShortTimeString() - 'COPY FINISHED'
Write-Host '--------------------------------'
if(!(Test-Path $destination)){
    copy-item -path $source -destination $destination
}

$current_time = Get-Date
Write-Host '--------------------------------'
Write-Host $current_time.ToShortTimeString() - 'INSTALLING', $software
Write-Host '--------------------------------'
Start-Process -FilePath $destination /q -Wait
$current_time = Get-Date
