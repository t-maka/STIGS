<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-20
    Last Modified   : 2025-08-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Windows-target-Labwill (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000005).ps1 
#>

# Define registry path for camera lock screen policy
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$Name    = "NoLockScreenCamera"
$Value   = 1  # 1 = Disabled, 0 = Enabled

# Create the registry key if missing
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Apply the setting
Set-ItemProperty -Path $RegPath -Name $Name -Value $Value -Type DWord

# Verify configuration
Get-ItemProperty -Path $RegPath | Select-Object $Name
