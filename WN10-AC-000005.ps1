<#
.SYNOPSIS
    This PowerShell script enforces WN10-AC-000005 by setting the Account Lockout Duration policy to 15 minutes, which is the DISA STIG minimum requirement.

.NOTES
    Author          : Tinan Makadjibeye
    LinkedIn        : linkedin.com/in/makadjibeye-tinan
    GitHub          : github.com/t-maka
    Date Created    : 2025-08-20
    Last Modified   : 2025-08-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Windows-target-Labwill (Windows 10)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000005).ps1 
#>

# This script configures the Account Lockout Duration to 15 minutes (or greater).
# Setting it to 0 (manual admin unlock) is also acceptable per STIG.

# Desired lockout duration (in minutes) – STIG minimum requirement = 15
$LockoutDuration = 15

# Apply the setting using net accounts command
# This updates the Local Security Policy (Account Lockout Duration)
net accounts /lockoutduration:$LockoutDuration

# Verify the current account policy settings
net accounts
