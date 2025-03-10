// Parameters
param location string

//Vnet Parameters
param vnetName string
param vnetAddressPrefix string

//Subnet parameters
param subnetArray array


param tags object

// Create Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
  }
  tags: tags
}


// Create Subnet
resource subnets 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' =  [for subnet in subnetArray:{
  parent: vnet
  name: subnet.name
  properties: {
    addressPrefix: subnet.addressPrefix
  }
}]

// Outputs
output vnetName string = vnet.name
output vnetId string = vnet.id
output subnetIds object = {
  stgSubnetId: subnets[0].id
  vmSubnetId: subnets[1].id
}

