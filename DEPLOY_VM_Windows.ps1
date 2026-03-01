$location = 'westeurope'
$rgName = 'rg-dev'
$vnetName = 'vnet-dev'
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $rgName
$subnet = $vnet.Subnets | Where-Object Name -EQ 'Subnet0'

$params = @{
    location = $location
    vmName = 'vm-dev-vm3'
    vmComputerName = 'VM3'
    vmAdminUserName = 'LocalAdmin'
    vmAdminPassword = Get-Content "./PASSWORDS" | ConvertFrom-Json | % { $_.localAdminPassword } | ConvertTo-SecureString
    subnetId = $subnet.Id
}

New-AzResourceGroupDeployment `
    -Name 'Test-vm-template' `
    -ResourceGroupName $rgName `
    -TemplateFile '.\templates\virtualMachineWindows.bicep' `
    @params