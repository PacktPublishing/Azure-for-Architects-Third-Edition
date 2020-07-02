Register-AzAutomationDscNode -ResourceGroupName 'automationrg' -AutomationAccountName 'bookaccount' -AzureVMLocation "west Europe" -AzureVMResourceGroup 'spark' -AzureVMName 'spark' -ConfigurationModeFrequencyMins 30 -ConfigurationMode 'ApplyAndAutoCorrect'

$node = Get-AzAutomationDscNode -ResourceGroupName 'automationrg' -AutomationAccountName 'bookaccount' -Name 'spark' 

Set-AzAutomationDscNode -ResourceGroupName 'automationrg' -AutomationAccountName 'bookaccount' -NodeConfigurationName 'ensureiis.localhost' -NodeId $node.Id 