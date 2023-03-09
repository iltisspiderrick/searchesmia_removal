### This Script deactivates and deletes the searchesmia-Searchenging-Extension for Google Chrome ###

# Those are all my known registryentries created by searchesmia for Google Chrome
$reg1 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"
$reg2 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\ExtensionInstallAllowlist"
$reg3 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Google\Chrome\Extension\jncffhgjbmpggpdflbbkhdghjipdbjkn"
$reg4 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Policies\Google\Chrome\ExtensionInstallForcelist"
$reg5 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Policies\Google\Chrome\ExtensionInstallAllowlist"
$reg6 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Google\Chrome\Extension\jncffhgjbmpggpdflbbkhdghjipdbjkn"
$reg7 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows"

# first the Tast will be stopped and deactived

if (Get-ScheduledTask -TaskName "GoogleUpdate" -TaskPath \) {
Stop-ScheduledTask -TaskName "GoogleUpdate" -TaskPath \
Disable-ScheduledTask -TaskName "GoogleUpdate" -TaskPath \
}

# now the all instances of chrome will be forcefully closed

if (Get-Process -Name "chrome") {
Stop-Process -Name "chrome" -Force
}

# the fake chrome-task will now be removed

if (Get-ScheduledTask -TaskName "GoogleUpdate" -TaskPath \) {
Unregister-ScheduledTask -TaskName "GoogleUpdate" -TaskPath \ -Confirm:$false
}

# at last the registry will be sanatized

if (Test-Path $reg1) {
Remove-Item $reg1 -Recurse
}
if (Test-Path $reg2) {
Remove-Item $reg2 -Recurse
}
if (Test-Path $reg3) {
Remove-Item $reg3 -Recurse
}
if (Test-Path $reg4) {
Remove-Item $reg4 -Recurse
}
if (Test-Path $reg5) {
Remove-Item $reg5 -Recurse
}
if (Test-Path $reg6) {
Remove-Item $reg6 -Recurse
}

if ((Get-ItemProperty -Path $reg7 -Name "AppInit_DLLs").AppInit_DLLs -ne "") {
Set-ItemProperty -Path $reg7 -Name "AppInit_DLLs" -Value ""
}
if ((Get-ItemProperty -Path $reg7 -Name "LoadAppInit_DLLs").LoadAppInit_DLLs -ne "0") {
Set-ItemProperty -Path $reg7 -Name "LoadAppInit_DLLs" -Value "0"
}

Write-Host "Searchesmia was successfully removed from Google Chrome"
