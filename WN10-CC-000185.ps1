<#
.SYNOPSIS
    This PowerShell script enforces WN10-CC-000185 by fully block Autoplay/Autorun to prevent autorun commands (full hardening).

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-20
    Last Modified   : 2025-08-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000185

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Windows-target-Labwill (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000185).ps1 
#>

# Configure the default Autorun behavior to prevent autorun commands
# Registry Path: HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer
# Value Name: NoAutorun
# Value Type: REG_DWORD
# Value: 1 (Disable Autorun)

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$regName = "NoAutorun"
$regValue = 1

# Ensure the registry key exists
If (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the setting
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord

Write-Output "Autorun has been disabled (WN10-CC-000185 remediated)."
