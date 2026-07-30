$location          = 'westeurope'
$resourceGroupName = 'rg-hybrididentity'
$vmName            = 'vm-hybrididentity-server1'
$vmComputerName    = 'Server1'
#$vmSize            = 'Standard_B2as_v2'     # defaults to 'Standard_D2as_v6'
$vmAdminUserName   = 'LocalAdmin'
$vnetName          = 'vnet-hybrididentity'
$subnetName        = 'Subnet0'
$deploymentName    = 'Deploy-infrastructure-vm0'
$deploymentName    = "Deploy-$vmName"

$passwordName = [string]::Concat($vmAdminUserName,'Password')
$vmAdminPassword = Get-Content "./PASSWORDS" | ConvertFrom-Json | % { $_.$passwordName } | ConvertTo-SecureString
$vnet = Get-AzVirtualNetwork -Name $vnetName
$subnet = $vnet.Subnets | Where-Object Name -EQ $subnetName
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
