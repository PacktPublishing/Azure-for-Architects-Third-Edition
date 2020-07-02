param(
    [parameter(mandatory=$true)]
    [string] $connectionName
)
$connection = Get-AutomationConnection  -name $connectionName  

$subscriptionid = $connection.subscriptionid

$tenantid = $connection.tenantid

$applicationid = $connection.applicationid

$cretThumbprint = $connection.CertificateThumbprint

Login-AzAccount -CertificateThumbprint $cretThumbprint -ApplicationId $applicationid -ServicePrincipal -Tenant $tenantid  -SubscriptionId  $subscriptionid

Get-AzVm