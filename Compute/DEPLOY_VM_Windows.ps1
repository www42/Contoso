$location          = 'swedencentral'
$resourceGroupName = 'rg-infrastructure'
$vmName            = 'vm-infrastructure-vm0'
$vmComputerName    = 'VM0'
$vmSize            = 'Standard_B2as_v2'     # defaults to 'Standard_D2as_v6'
$vmAdminUserName   = 'LocalAdmin'
$vnetName          = 'vnet-hub'
$deploymentName    = 'Deploy-infrastructure-vm0'

$passwordName = [string]::Concat($vmAdminUserName,'Password')
$vmAdminPassword = Get-Content "./PASSWORDS" | ConvertFrom-Json | % { $_.$passwordName } | ConvertTo-SecureString
$vnet = Get-AzVirtualNetwork -Name $vnetName
$subnet = $vnet.Subnets | Where-Object Name -EQ 'Subnet0'
$subnetId = $subnet.Id

$params = @{
    location = $location
    vmName = $vmName
    vmComputerName = $vmComputerName
    vmSize = $vmSize
    vmAdminUserName = $vmAdminUserName
    vmAdminPassword = $vmAdminPassword
    subnetId = $subnetId
}

New-AzResourceGroupDeployment `
    -Name $deploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile '.\templates\virtualMachineWindows.bicep' `
    @params