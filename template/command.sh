# build main.bicep file
: '
az bicep build -file <bicep file name>
'
az bicep build --file .\001\001_stg.bicep

az bicep build --file .\001\001_rg.bicep


az bicep decompile --file 

# build main.bicep file with out-dir
az bicep build --file .\main.bicep --outfile test.json




# Create Resource groupo using az cli

az group create --name rgAppNameDev --location centralindia


# Create deployment 
: '
az deployment group create --resource-group <resource-group-name> --template-file <path-to-bicep>
'

# Preview Changes before Deployment
az deployment group create --resource-group rgAppNameDev --template-file .\001\001_stg.bicep --what-if

az deployment group create --resource-group rgAppNameDev --template-file .\001\001_stg.bicep

# if have multiple subscription 

az deployment group create --subcriptionname <name of the sub> --resource-group rgAppNameDev --template-file .\001\001_stg.bicep

# deploy with parameter file

az deployment group create --resource-group rgAppNameDev --template-file 001/001_stg_param.bicep --parameters "001/001_stg_param.parameters.json"