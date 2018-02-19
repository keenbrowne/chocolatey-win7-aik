$ErrorActionPreference = 'Stop'; # stop on all errors

Get-ChocolateyWebFile 'KB3AIK_EN' "$env:Temp\KB3AIK_EN.iso" 'https://download.microsoft.com/download/8/E/9/8E9BBC64-E6F8-457C-9B8D-F6C9A16E6D6A/KB3AIK_EN.iso'

# Next, mount the ISO file, ready for using it's contents (NOTE: the last parameter here is the drive letter that will be assigned to the mounted ISO)
imdisk -a -f "$env:Temp\KB3AIK_EN.iso" -m "W:"

$packageName= $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'W:\wAIKX86.msi'
$url64      = 'W:\wAIKAMD64.msi'
$mstPath    = Join-Path $toolsDir "win7-aikInstall-uilevel.mst"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  useOriginalLocation = $True
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64

  softwareName  = 'Windows Automated Instalation Kit*'

  checksum      = '316B1987DA3158E0AA2F0AA50D5E9E855B82069DD29ECA4832EDEF3CCA278FD9'
  checksumType  = 'sha256'
  checksum64    = '31D4EEF5FD3664BE3442181BF5980713BEDD8D20923114E134DC5867CFE1C16F'
  checksumType64= 'sha256'

  # MSI
  silentArgs    = "/qn /norestart TRANSFORMS=`"$($mstPath)`" /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Unmount the ISO file when finished
imdisk -d -m W:

