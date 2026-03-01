$clientSecret = Read-Host -Prompt 'Client Secret' -AsSecureString | ConvertFrom-SecureString
$clientSecretPlainText = Read-Host -Prompt 'Client Secret'
$localAdminPassword = Read-Host -Prompt 'LocalAdmin password' -AsSecureString | ConvertFrom-SecureString
$domainAdminPassword = Read-Host -Prompt 'DomainAdmin password' -AsSecureString | ConvertFrom-SecureString
@{
    'clientSecret' = $clientSecret
    'clientSecretPlainText' = $clientSecretPlainText
    'localAdminPassword' = $localAdminPassword
    'domainAdminPassword' = $domainAdminPassword
} | ConvertTo-Json | Out-File "./PASSWORDS"