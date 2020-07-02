param(
    [parameter(mandatory=$true)]
    [object] $WebhookData
)

$webhookname = $WebhookData.WebhookName

$headers = $WebhookData.RequestHeader

$body = $WebhookData.RequestBody

Write-output "webhook header data"

Write-Output $webhookname

Write-output $headers.message

Write-output $headers.subject

$connectionname = (ConvertFrom-Json -InputObject $body) ./connectAzure.ps1 -connectionName  $connectionname[0].name
