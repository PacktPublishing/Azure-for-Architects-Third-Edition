New-AzResourceGroupDeployment -Name "testdeploy1" -ResourceGroupName
testvmrg -Mode Incremental -TemplateFile "Master.json"
-storageAccountName "" -storageType "Standard_LRS"
-publicIPAddressName "" -publicIPAddressType "Dynamic"
-dnsNameForPublicIP "" -virtualNetworkName
vnetwork01 -addressPrefix "10.0.1.0/16" -subnetName "subnet01" -subnetPrefix
"10.0.1.0/24" -nicName nic02 -vmSize "Standard_DS1" -adminUsername ""
-adminPassword $(ConvertTo-SecureString -String "" -AsPlainText
-Force) -vhdStorageName "" -vhdStorageContainerName ""
-OSDiskName "" -vmName "" -windowsOSVersion 2012-R2-Datacenter
-imagePublisher MicrosoftWindowsServer -imageOffer WindowsServer
-containerName armtemplates -Verbose