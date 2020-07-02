#
# docker.ps1
#
Install-PackageProvider -Name Nuget -Force -ForceBootstrap -Confirm:$false
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force -
Confirm:$false -verbose
Install-Package -Name docker -ProviderName DockerMsftProvider -Force -
ForceBootstrap -Confirm:$false