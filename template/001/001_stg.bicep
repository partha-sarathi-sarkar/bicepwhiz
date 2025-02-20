// Basic Storage Template

resource stgAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'stg001demodev'
  location: 'centralindia'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
