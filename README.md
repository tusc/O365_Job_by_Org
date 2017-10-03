# O365_Job_by_Org
Powershell to create Veeam Backup O365 jobs by Organizational unit.

This script allows you to create a O365 backup job based on Organizational unit. This comes in handy when you want to define a job based on a subset of the users in a given Exchange organization without having to click hundreds of user accounts from the GUI.

The script below  builds a list of mailboxes that are then passed to the  Add-VBOJob cmdlet for creating a new job. If the job already exists it updates it with Set-VBOJob.
