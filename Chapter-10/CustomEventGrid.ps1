New-AzEventGridTopic -ResourceGroupName CustomEventGridDemo -Name "KeyVaultAssetsExpiry" -Location "West Europe"


$topicEndpoint = (Get-AzEventGridTopic -ResourceGroupName containers -Name KeyVaultAssetsExpiry).Endpoint
$keys = (Get-AzEventGridTopicKey -ResourceGroupName containers -Name KeyVaultAssetsExpiry).Key1


$eventgridDataMessage = @{
	id = [System.guid]::NewGuid()
	subject = "Key Vault Asset Expiry"
	eventType = "Certificate Expiry"
	eventTime = [System.DateTime]::UtcNow

data = @{
	CertificateThumbprint = "sdfervdserwetsgfhgdg"
	ExpiryDate = "1/1/2019"
	Createdon = "1/1/2018"
	}
}

$finalBody = "[" + $(ConvertTo-Json $eventgridDataMessage) + "]"

$header = @{
	"contentType" = "application/json"
	"aeg-sas-key" = $keys
}


New-AzEventGridSubscription -TopicName KeyVaultAssetsExpiry -EventSubscriptionName "customtopicsubscriptionautocar" -ResourceGroupName CustomEventGridDemo -EndpointType webhook -Endpoint "https://durablefunctiondemoapp.azurewebsites.net/runtime/webhooks/EventGrid?functionName=StorageEventHandler&code=0aSw6sxvtFmafXHvt7iOw/Dsb8o1M9RKKagzVchTUkwe9EIkzl4mCg==" -Verbose

Invoke-WebRequest -Uri $topicEndpoint -Body $finalBody -Headers $header -Method Post