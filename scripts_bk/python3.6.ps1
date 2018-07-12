$script_root = $PSScriptRoot

$local_resources = 'C:\deployment'

$install_directory = "C:\Python27\python.exe"
$url = "https://www.python.org/ftp/python/3.6.4/python-3.6.4-amd64.exe"
$output = "C:\deployment\python-3.6.4.exe"
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
Write-Host $current_time.ToShortTimeString() - 'DOWNLOADING PYTHON 3.6.4'
Write-Host '--------------------------------'
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
$current_time = Get-Date
Write-Host '--------------------------------'
Write-Host $current_time.ToShortTimeString() - 'DOWNLOAD FINISHED'
Write-Host '--------------------------------'
$current_time = Get-Date
Write-Host '--------------------------------'
Write-Host $current_time.ToShortTimeString() - 'INSTALLING PYTHON 3.6.4'
Write-Host '--------------------------------'
Start-Process -FilePath $output $command
$current_time = Get-Date
Read-Host -Prompt "Press Enter to exit"
-noexit
