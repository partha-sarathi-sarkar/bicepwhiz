
// Set the deployment Scope to subscription level
targetScope = 'subscription'


resource rgdev 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'rgAppNameDev'
  location: 'centralindia'
}
