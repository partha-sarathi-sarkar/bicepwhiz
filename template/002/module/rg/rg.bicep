
targetScope = 'subscription'

// Parameters
param location string 
param resourceGroupName string

// Create Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2024-11-01' ={
  name: resourceGroupName
  location: location
}

// Outputs
output resourceGroupName string = rg.name
output location string = rg.location
