# Summary
Chocolatey Package for The Windows Automated Installation Kit (AIK) for 
Windows 7

For more information see: https://www.microsoft.com/en-us/download/details.aspx?id=5753

# Description
This chocolatey file downloads the AIK ISO, applies an MST to the MSI to
enable silent install and installs it.

# Requirements
 1. Chocolatey

# Manual Build & Test Instructions
```powershell
PS> choco pack
PS> choco install win7-aik -dv -s .
```
