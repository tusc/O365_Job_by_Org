Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn;

$VeeamBackupJobName = "ABC Backup"
$VeeamRepository = "MailBackup"
$OrgUnit = "OU=BR,DC=ACME,DC=local"                                # This example searches for users located in Brazil.

$org = Get-VBOOrganization                                         # Retruns Exchange Organization
$repository = Get-VBORepository -Name $VeeamRepository             # Veeam O365 Repository

# O365 PowerShell call - Return all Exchange Mailboxes
$MailBoxes = Get-VBOOrganizationMailbox -Organization $org

# Exchange Powershell call - Return all Exchange Mailboex under the Organitional Unit $OrgUnit defined above.
$mbxs = Get-Mailbox -OrganizationalUnit $OrgUnit -ResultSize Unlimited

$FinalList = @()

#Nested for loop to compare the contents of the Exchange list vs. the Get-VBOOrg..list. Only add matches based
#on email address.
ForEach ($MailBox in $MailBoxes) {
  ForEach ($mbx in $mbxs) {

     if ($MailBox.Email -match $mbx.EmailAddresses[0].AddressString ) {
         Write-Host $mbx.EmailAddresses[0].AddressString
         $FinalList += @($MailBox)
     }
  }
}

If ($JobId = Get-VBOJob -Name $VeeamBackupJobName) {
    write-host "Job Exists! Updating Job"
    $results = Set-VBOJob -Job $JobId -Repository $repository -SelectedMailboxes $FinalList
} else {
    $results = Add-VBOJob -Name  $VeeamBackupJobName -Organization $org -Repository $repository -SelectedMailboxes $FinalList
}

Write-Host "Number of Mailboxes in the OU $OrgUnit = " $mbxs.count
