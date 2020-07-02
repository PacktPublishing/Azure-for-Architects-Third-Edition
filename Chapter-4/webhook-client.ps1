$uri = "url of the webhook runbook"
$connection  = @(
            @{  name="azureforarchitectsconnection"}
           
        )
$body = ConvertTo-Json -InputObject $ connection  

$header = @{ subject="VMS specific to Ritesh";message="Get all virtual machine details"}
        
$response = Invoke-WebRequest -Method Post -Uri $uri -Body $body -Headers

$header

$jobid = (ConvertFrom-Json ($response.Content)).jobids[0] 