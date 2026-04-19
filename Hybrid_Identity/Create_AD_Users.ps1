# ------------------------------------------------------------------------------------
# Scenario Hybrid Identity
# ------------------------------------------------------------------------------------
# This creates OnPrem AD users.
# Run this script on the domain controller VM.
# ------------------------------------------------------------------------------------

Import-Module -Name activedirectory
$Domain = Get-ADDomain | % forest
$OU = New-ADOrganizationalUnit -Name 'Physics' -PassThru
$Group = New-ADGroup -Name 'Physics' -DisplayName 'Physics' -GroupScope Global -Path $OU.DistinguishedName -PassThru
$Names = Import-Csv -Path ./AD_Users.csv

foreach ($Name in $Names) {
    $SecurePW = ConvertTo-SecureString -String $Name.Password -AsPlainText -Force
    $UserName = $Name.FirstName + " " + $Name.SurName 
    $User = New-ADUser -Name "$UserName" `
                       -DisplayName "$UserName" `
                       -GivenName "$($Name.FirstName)" `
                       -Surname "$($Name.SurName)" `
                       -UserPrincipalName "$($Name.Login)@$Domain" `
                       -SamAccountName "$($Name.Login)" `
                       -Path $OU.DistinguishedName `
                       -AccountPassword $SecurePW `
                       -PasswordNeverExpires $true `
                       -Enabled $true `
                       -PassThru
    Add-ADGroupMember -Members $User -Identity $Group 
}
