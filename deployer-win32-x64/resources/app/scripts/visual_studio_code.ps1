$script_root = $PSScriptRoot

$software = "VISUAL STUDIO CODE"

$local_resources = 'C:\deployment'

$url = "https://az764295.vo.msecnd.net/stable/f88bbf9137d24d36d968ea6b2911786bfe103002/VSCodeSetup-x64-1.20.1.exe"
$output = "C:\deployment\visual_studio_code.exe"
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
Start-Process -FilePath $output /Silent -Wait
$current_time = Get-Date
