<#
.SYNOPSIS
    This PowerShell script enforces DISA STIG WN10-CC-000100 by preventing the system from downloading print driver packages over HTTP.

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-20
    Last Modified   : 2025-08-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000100

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Windows-target-Labwill (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000100).ps1 
#>

# Define registry path and setting
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$Name    = "DisableWebPnPDownload"
$Value   = 1  # 1 = Disabled, 0 = Enabled

# Create the registry key if it does not exist
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Apply the setting
Set-ItemProperty -Path $RegPath -Name $Name -Value $Value -Type DWord

# Verify configuration
Get-ItemProperty -Path $RegPath | Select-Object $Name


# Verify configuration
Get-ItemProperty -Path $RegPath | Select-Object $Name
