// Parameters
@description('location of the resources')
param location string = resourceGroup().location

@description('Virtual Network Name')
param vnetName string

@description('Virtual network address Prefix')
param vnetAddressPrefix string

@description('Subnet Name')
param subnetArray array

@description('Resource tag')
param tags object

// Storage Account Variable
param storageaccount_name string

@description('Storage Account sku')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storage_sku string // This is selected at pipeline runtime

@description('Storage account kind')
@allowed([
  'Storage'
  'StorageV2'
  'BlobStorage'
  'FileStorage'
  'BlockBlobStorage'
])
param storage_kind string // Storage Account Kind 

@description('Containers') // List your container names here in the array
param container_names array

// Create vnet and subnet
module networkingModule 'module/networking/private_network.bicep' = {
  name: 'networkingdev'
  params: {
    location: location
    subnetArray: subnetArray
    vnetAddressPrefix: vnetAddressPrefix
    vnetName: vnetName
    tags: tags
  }
}

// Storage Account + config 
module Storage_AccountModule 'module/storage/stg.bicep' = {
  name: 'StorageAccount_Deploy'
  params: {
    storageaccount_name: storageaccount_name
    storageaccount_tags: tags
    storageaccount_location: location
    storage_sku: storage_sku
    container_names:container_names
    storage_kind: storage_kind
    subnetId: networkingModule.outputs.subnetIds.stgSubnetId
  }
  dependsOn:[
    networkingModule
  ]
}

// Pipeline Outputs
output Resource_Group string = resourceGroup().name
output StorageAccount_Resource_Created string = Storage_AccountModule.outputs.storageaccount_name
output StorageAccount_Containers array =  Storage_AccountModule.outputs.Container_names

// Vnet Outputs
output vnetName string = networkingModule.outputs.vnetName
output vnetId string = networkingModule.outputs.vnetId

// Subnet outputs
output subnetIds object = networkingModule.outputs.subnetIds
