@description('The unique name for the storage account.')
@minLength(3)
@maxLength(24)
param storageAccountName string

@description('The Azure region where the storage account will be deployed.')
@allowed(['eastus', 'westus', 'centralindia'])
param location string

@description('The SKU of the storage account.')
@allowed(['Standard_LRS', 'Standard_GRS', 'Premium_LRS'])
param sku string

@description('The kind of storage account.')
@allowed(['StorageV2', 'BlobStorage', 'FileStorage'])
param kind string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: sku
  }
  kind: kind
}


// Return the Storage Account Id
output storageAccountId string = storageAccount.id 

// Return the Storage Account Name
output storageAccountName string = storageAccount.name
