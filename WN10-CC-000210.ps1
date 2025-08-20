<#
.SYNOPSIS
    This PowerShell script enforces DISA STIG WN10-CC-000210 by enabling Windows Defender SmartScreen for File Explorer across different Windows 10 builds, including 1507 LTSB and 1607 LTSB.

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000210

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Windows-target-Labwill (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000210).ps1 
#>

# Define registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"

# Create the registry key if missing
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Detect Windows 10 build version
$WinVer = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId

# Default values
$EnableSmartScreenValue = 1
$ShellSmartScreenLevel  = "Block"

# Handle special cases for older LTSB builds
Switch ($WinVer) {
    "1507" { $EnableSmartScreenValue = 2 }   # v1507 LTSB requires value = 2
    "1607" { $EnableSmartScreenValue = 1 }   # v1607 LTSB = 1 (same as default)
    Default { $EnableSmartScreenValue = 1 }  # Current Windows 10 = 1
}

# Apply registry settings
Set-ItemProperty -Path $RegPath -Name "EnableSmartScreen" -Value $EnableSmartScreenValue -Type DWord
Set-ItemProperty -Path $RegPath -Name "ShellSmartScreenLevel" -Value $ShellSmartScreenLevel -Type String

# Verify configuration
Get-ItemProperty -Path $RegPath | Select-Object EnableSmartScreen, ShellSmartScreenLevel
