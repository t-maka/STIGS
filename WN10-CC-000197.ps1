<#
.SYNOPSIS
    This PowerShell script enforces DISA STIG WN10-CC-000197 by disabling Microsoft Consumer Experiences on Windows 10.
    Applies to Windows 10 (NA for v1507 LTSB)

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-25
    Last Modified   : 2025-08-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000197

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Labwill-Win10-target (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000197).ps1 
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"

# Ensure the registry path exists
If (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set DisableWindowsConsumerFeatures to 1
New-ItemProperty -Path $regPath -Name "DisableWindowsConsumerFeatures" -Value 1 -PropertyType DWord -Force | Out-Null

Write-Output "Configured: Microsoft Consumer Experiences are disabled."
