resource stgDecompileDemoDev 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'stgDecompileDemoDev'
  location: 'East US'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
