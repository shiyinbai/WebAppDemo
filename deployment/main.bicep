targetScope='subscription'

@description('Required. A unique suffix to add to resource names that need to be globally unique.')
@maxLength(13)
param resourceNameSuffix string

@description('The Azure region into which the resources should be deployed.')
param location string 

var resourceGroupName = 'rg-${resourceNameSuffix}'

resource newRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: resourceGroupName
  location: location
}

module appService 'appService.bicep' = {
  name: 'appServiceModule'
  scope: newRG
  params: {
    location:location
    environmentType:'nonprod'
    resourceNameSuffix:resourceNameSuffix
  }
}
