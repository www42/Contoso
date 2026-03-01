param location string
param vmName string
param vmComputerName string
param vmSize string = 'Standard_D2as_v6'
param vmAdminUserName string
@secure()
param vmAdminPassword string
param subnetId string

var vmImageSku = '2025-datacenter-azure-edition'
var vmOsDiskName = 'disk-${vmName}'
var vmNicName = 'nic-${vmName}'
var vmNsgName = 'nsg-${vmName}'

resource vm 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: vmImageSku
        version: 'latest'
      }
      osDisk: {
        name: vmOsDiskName
        osType: 'Windows'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        deleteOption: 'Delete'
        diskSizeGB: 127
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
    }
    osProfile: {
      computerName: vmComputerName
      adminUsername: vmAdminUserName
      adminPassword: vmAdminPassword
      windowsConfiguration: {
        timeZone: 'W. Europe Standard Time'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}
resource nic 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: vmNicName
  location: location
  properties: {
    networkSecurityGroup: {
      id: nsg.id
    }
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}
resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: vmNsgName
  location: location
}

output vmId string = vm.id
