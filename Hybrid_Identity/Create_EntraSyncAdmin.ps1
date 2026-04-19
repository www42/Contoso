# Create
$tenantId = Get-MgContext | % TenantId
Get-MgOrganization -OrganizationId $tenantId | % VerifiedDomains
$domainName = 'contoso69118.com'

$password = Read-Host -Prompt 'Password'
$passwordProfile = @{
    Password = $password
    ForceChangePasswordNextSignIn = $false
}

$params = @{
    DisplayName = 'EntraSyncAdmin'
    UserPrincipalName = "EntraSyncAdmin@$domainName"
    MailNickname = 'EntraSyncAdmin'
    UsageLocation = 'DE'
    AccountEnabled = $true
    PasswordProfile = $passwordProfile
}
$EntraSyncAdmin = New-MgUser @params

# Assign role
$EntraSyncAdmin = Get-MgUser -Filter "displayName eq 'EntraSyncAdmin'"
$roleDisplayName = 'Hybrid Identity Administrator'
$role = Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq '$roleDisplayName'" 
New-MgRoleManagementDirectoryRoleAssignment -RoleDefinitionId $role.Id -PrincipalId $EntraSyncAdmin.Id -DirectoryScopeId "/"

# Delete
$EntraSyncAdmin = Get-MgUser -Filter "displayName eq 'EntraSyncAdmin'"
Remove-MgUser -UserId $EntraSyncAdmin.Id