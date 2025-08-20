<#
.SYNOPSIS
    This PowerShell script enforces the DISA STIG WN10-AC-000035 requirement by setting the minimum password length to 14 characters.

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-20
    Last Modified   : 2025-08-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Windows-target-Labwill (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000035).ps1 
#>

# Set the minimum password length to 14 characters
$SecPolFile = "$env:TEMP\secpol.cfg"
$SecPolOut  = "$env:TEMP\secpol_out.cfg"

# Export current security policy
secedit /export /cfg $SecPolFile

# Update the MinimumPasswordLength setting
(Get-Content $SecPolFile) |
    ForEach-Object {
        if ($_ -match "^MinimumPasswordLength") {
            "MinimumPasswordLength = 14"
        } else {
            $_
        }
    } | Set-Content $SecPolOut

# Apply the updated security policy
secedit /configure /db secedit.sdb /cfg $SecPolOut /areas SECURITYPOLICY

# Cleanup
Remove-Item $SecPolFile, $SecPolOut -Force

# Verify setting
(Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters").MinimumPasswordLength
