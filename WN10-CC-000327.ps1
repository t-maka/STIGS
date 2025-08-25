<#
.SYNOPSIS
    This PowerShell script enforces WN10-CC-000327 by enabling PowerShell Transcription on Windows 10.

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-25
    Last Modified   : 2025-08-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000327

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Labwill-Win10-target (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000327).ps1 
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"
$regName = "EnableTranscripting"
$regValue = 1

# Ensure the registry path exists
If (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set EnableTranscripting to 1 (enable transcription logging)
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Output "Configured: PowerShell Transcription has been enabled (WN10-CC-000327 remediated)."
