<#
.SYNOPSIS
    This PowerShell script enforces WN10-CC-000195 by enabling Enhanced Anti-Spoofing for Windows Hello facial recognition.

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-20
    Last Modified   : 2025-08-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000195

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Windows-target-Labwill (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000195).ps1 
#>

# Define registry path for Windows Hello Enhanced Anti-Spoofing
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures"
$Name    = "EnhancedAntiSpoofing"
$Value   = 1  # 1 = Enabled

# Create the registry path if it doesn't exist
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Apply the registry setting
Set-ItemProperty -Path $RegPath -Name $Name -Value $Value -Type DWord

# Verify configuration
Get-ItemProperty -Path $RegPath | Select-Object $Name
