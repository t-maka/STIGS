<#
.SYNOPSIS
    This PowerShell script enforces WN10-CC-000035 by configuring system to ignore NetBIOS name release requests except from WINS servers.
    
.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-25
    Last Modified   : 2025-08-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Labwill-Win10-target (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000035).ps1 
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters"
$regName = "NoNameReleaseOnDemand"
$regValue = 1

# Ensure the registry path exists
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the required registry setting
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Output "Configured: NetBIOS name release requests are now ignored unless from WINS servers (WN10-CC-000035 remediated)."
