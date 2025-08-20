<#
.SYNOPSIS
    This PowerShell script enforces DISA STIG WN10-00-000175 by disabling the Secondary Logon service (seclogon) on Windows 10.

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-20
    Last Modified   : 2025-08-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000175

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Windows-target-Labwill (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000175).ps1 
#>

# Define the service
$ServiceName = "seclogon"

# Stop the service if running
If ((Get-Service -Name $ServiceName).Status -eq 'Running') {
    Stop-Service -Name $ServiceName -Force
}

# Disable the service
Set-Service -Name $ServiceName -StartupType Disabled

# Verify
Get-Service -Name $ServiceName | Select-Object Name, Status, StartType
