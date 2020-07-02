$params = @{"connectionName"="azureforarchitectsconnection"}

$job = Start-AzurermAutomationRunbook '
    –AutomationAccountName 'bookaccount' '
    –Name 'ConnectAzure' '
    -ResourceGroupName 'automationrg' -parameters $params

if($job -ne $null) {
    Start-Sleep -s 100

    $job = Get-AzureAutomationJob -Id $job.Id -AutomationAccountName 'bookaccount'
    if ($job.Status -match "Completed") {
        $jobout = Get-AzureAutomationJobOutput -Id $job.Id -AutomationAccountName 'bookaccount' -Stream Output
                    if ($jobout) {Write-Output $jobout.Text}
    }
}