# This script creates a file "./PASSWORDS"
#
# "./PASSWORDS" is red by LOGIN.ps1 in order to log into Azure
# "./PASSWORDS" is red by other script to get secret.
#
# 'Client Secret powershell' 
#       ist das Client Secret für die App Registration 'powershell'
#       Get-MgApplication -Filter "displayName eq 'powershell'"
#
# 'LocalAdmin password'
#       ist das Password für einen lokalen Administrator (bei VMs z.B.)
#
# 'DomainAdmin password'
#       ist das Password für den Domänen Administrator (Active Directory)

$clientSecret = Read-Host -Prompt 'Client Secret powershell' -AsSecureString | ConvertFrom-SecureString
$clientSecretPlainText = Read-Host -Prompt 'Client Secret powershell'
$localAdminPassword = Read-Host -Prompt 'LocalAdmin password' -AsSecureString | ConvertFrom-SecureString
$domainAdminPassword = Read-Host -Prompt 'DomainAdmin password' -AsSecureString | ConvertFrom-SecureString
@{
    'clientSecret' = $clientSecret
    'clientSecretPlainText' = $clientSecretPlainText
    'localAdminPassword' = $localAdminPassword
    'domainAdminPassword' = $domainAdminPassword
} | ConvertTo-Json | Out-File "./PASSWORDS"