<#
.SYNOPSIS
    This PowerShell script enforces WN10-CC-000030 by preventing ICMP redirects from overriding OSPF routes

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-25
    Last Modified   : 2025-08-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Labwill-Win10-target (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000030).ps1 
#>

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$regName = "EnableICMPRedirect"
$regValue = 0

# Ensure the registry path exists
If (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set EnableICMPRedirect to 0 (disable ICMP redirects)
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Output "Configured: ICMP redirects are disabled (WN10-CC-000030 remediated)."
