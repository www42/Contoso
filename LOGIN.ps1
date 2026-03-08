# Login to Azure and Microsoft Graph
#
$tenantId = '4fc7dd0c-5c8d-405e-a415-189fe82fb2bb'
$clientId = '776cca4e-a126-4efb-ad31-ed873a131b3c'
$clientSecretPlainText = Get-Content "./PASSWORDS" | ConvertFrom-Json | % { $_.clientSecretPlainText }
$clientSecretSecure = Get-Content "./PASSWORDS" | ConvertFrom-Json | % { $_.clientSecret } | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PSCredential($clientId, $clientSecretSecure)

# Login to Azure using PowerShell
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