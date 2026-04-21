extension microsoftGraphV1

param groupUniqueName string 
param groupDisplayName string
param groupmailNickname string

resource group 'Microsoft.Graph/groups@v1.0' = {
  uniqueName: groupUniqueName
  displayName: groupDisplayName
  mailNickname: groupmailNickname
  mailEnabled: false
  securityEnabled: true
}
