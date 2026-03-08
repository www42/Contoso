$location = 'westeurope'
$rgName = 'rg-prod'
$vnetName = 'vnet-prod'
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $rgName
$subnet = $vnet.Subnets | Where-Object Name -EQ 'Subnet0'

$params = @{
    location = $location
    vmName = 'vm-prod-dc1'
    vmComputerName = 'DC1'
    vmAdminUserName = 'DomainAdmin'
    vmAdminPassword = Get-Content "./PASSWORDS" | ConvertFrom-Json | % { $_.domainAdminPassword } | ConvertTo-SecureString
    subnetId = $subnet.Id
}

New-AzResourceGroupDeployment `
    -Name 'Deploy-prod-dc1' `
    -ResourceGroupName $rgName `
    -TemplateFile '.\templates\virtualMachineWindows.bicep' `
    @params