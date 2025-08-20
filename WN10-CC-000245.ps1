<#
.SYNOPSIS
    This PowerShell script enforces DISA STIG WN10-CC-000245 by disabling the password manager in Microsoft Edge.

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-20
    Last Modified   : 2025-08-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000245

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Windows-target-Labwill (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000245).ps1 
#>

# Define registry path for Microsoft Edge password manager policy
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main"
$Name    = "FormSuggest Passwords"
$Value   = "no"   # "no" = disable password manager, "yes" = enable

# Create the registry key if missing
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Apply the setting
Set-ItemProperty -Path $RegPath -Name $Name -Value $Value -Type String

# Verify configuration
Get-ItemProperty -Path $RegPath | Select-Object $Name
