# O365_Job_by_Org
Powershell to create Veeam Backup O365 jobs by Organizational unit.

I've been playing around with the new O365 1.5 PowerShell cmdlets and trying to determine a way to define a VBO job based on an OU value.
I have a customer that would like to create jobs that are defined by geographic region. With thousands of entries, 
it makes sense to script this. By OU I am referring to the parameter used with the Exchange PowerShell call
Get-Mailbox -OrganizationalUnit.

The cmdlet, Add-VBOJob, lets you define a list of mailboxes. This is great but there is no way to define which OU these mailboxes are 
part of, for example, OU=EMEA or DC=ACME. I put together the script below that builds a list of mailboxes that are then passed to the 
Add-VBOJob cmdlet for creating a new job. If the job already exists it updates it with Set-VBOJob.

