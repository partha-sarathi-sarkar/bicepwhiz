param storageaccount_name string
param storageaccount_tags object
param storageaccount_location string
param subnetId string

param storage_sku string // This is selected at pipeline runtime

param storage_kind string = 'StorageV2' // Storage Account Kind 


@description('Containers') // List your container names here in the array
param container_names array 

// Storage Account V2
resource StorageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageaccount_name
  location: storageaccount_location
  tags: storageaccount_tags
  kind: storage_kind
  properties: {
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      virtualNetworkRules: [
        {
          id: subnetId
          action: 'Allow'
        }
      ]
    }
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: storage_sku
  }
}

// Blob Services - Settings
resource Blob_Services 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: StorageAccount
  name: 'default'
  properties: {
    lastAccessTimeTrackingPolicy: {
      blobType: [
        'string'
      ]
      enable: true
      name: 'AccessTimeTracking'
      trackingGranularityInDays: 1
    }
  }
}

// Create Containers
resource Containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = [for containerName in container_names: {
  name: containerName
  parent: Blob_Services
  properties: {
    publicAccess: 'None'
  }
}]

// Outputs
output storageaccount_name string = storageaccount_name
output Container_names array = container_names
