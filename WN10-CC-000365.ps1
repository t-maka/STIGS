<#
.SYNOPSIS
    This PowerShell script remediates WN10-CC-000365. It prevents Windows apps from being activated by voice when system is locked
    Applies to Windows 10 v1903 or later

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-25
    Last Modified   : 2025-08-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000365

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : LabWill-Win10-target (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000365).ps1 
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"

# Ensure the registry path exists
If (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Check if "LetAppsActivateWithVoice" is configured to disallow voice activation for all users (2)
# If so, "LetAppsActivateWithVoiceAboveLock" is NA and does not need to be set.
$letAppsActivateWithVoice = Get-ItemProperty -Path $regPath -Name "LetAppsActivateWithVoice" -ErrorAction SilentlyContinue

if ($null -eq $letAppsActivateWithVoice -or $letAppsActivateWithVoice.LetAppsActivateWithVoice -ne 2) {
    # Configure "LetAppsActivateWithVoiceAboveLock" to 2 to block voice activation above lock screen
    New-ItemProperty -Path $regPath -Name "LetAppsActivateWithVoiceAboveLock" -Value 2 -PropertyType DWord -Force | Out-Null
    Write-Output "Configured: Prevent Windows apps from being activated by voice when locked."
}
else {
    Write-Output "Requirement is NA: 'LetAppsActivateWithVoice' is already set to disallow all voice activation."
}
