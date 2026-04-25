$rgName = 'rg-prod'

$params = @{
    groupUniqueName = 'myExampleGroup'
    groupDisplayName = 'My example group'
    groupmailNickname = 'my-example-group'
}

New-AzResourceGroupDeployment `
    -Name 'Deploy-Entra-Group' `
    -ResourceGroupName $rgName `
    -TemplateFile '.\templates\entraGroup.bicep' `
    @params

# Remove
$group = Get-MgGroup -Filter "displayName eq '$($params.groupDisplayName)'"
Remove-MgGroup -GroupId $group.Id