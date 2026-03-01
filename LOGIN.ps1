# Save Client Secret locally as Secure String for Powershell
# (put PASSWORDS into .gitignore)
#   $clientSecret = Read-Host -Prompt 'Client Secret' -AsSecureString | ConvertFrom-SecureString
#   @{'clientSecret' = $clientSecret} | ConvertTo-Json | Out-File "./PASSWORDS"

# Save Client Secret locally as plain text for Azure CLI 
# (put SECRETS into .gitignore)
#   $clientSecretPlainText = Read-Host -Prompt 'Client Secret'
#   @{'clientSecretPlainText' = $clientSecretPlainText} | ConvertTo-Json | Out-File "./SECRETS"



# --- Service Principals -------------------------------------------------------------
$tenantId = '4fc7dd0c-5c8d-405e-a415-189fe82fb2bb'
$clientId = '776cca4e-a126-4efb-ad31-ed873a131b3c'
$clientSecretPlainText = Get-Content "./PASSWORDS" | ConvertFrom-Json | % { $_.clientSecretPlainText }
$clientSecretSecure = Get-Content "./PASSWORDS" | ConvertFrom-Json | % { $_.clientSecret } | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PSCredential($clientId, $clientSecretSecure)

# Login to Azure
Disconnect-AzAccount
Connect-AzAccount -TenantId $tenantId -Credential $credential -ServicePrincipal
Get-AzContext | Format-List Tenant, Account, Subscription

# Login to Microsoft Graph
Disconnect-MgGraph
Connect-MgGraph -TenantId $tenantId -ClientSecretCredential $credential -NoWelcome
Get-MgContext | Format-List TenantId, ClientId, Scopes
Get-MgContext | % Scopes | Sort-Object


# Login to Azure using CLI
az logout
az login --service-principal --username $clientId --password $clientSecretPlainText --tenant $tenantId
az account show