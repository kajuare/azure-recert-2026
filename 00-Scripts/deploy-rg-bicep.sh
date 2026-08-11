#!/bin/bash
set -e

# Prompt user for input
read -p "Enter the Resource Group name: " RG_NAME
read -p "Enter the location (e.g. eastus, westeurope): " RG_LOCATION

# Create Bicep file on the fly
cat > rg-template.bicep << EOF
targetScope = 'subscription'

param rgName string
param rgLocation string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: rgLocation
}
EOF

echo "Deploying Resource Group '$RG_NAME' in '$RG_LOCATION' using Bicep..."

az deployment sub create \
  --name "createRg-$RG_NAME" \
  --location "$RG_LOCATION" \
  --template-file rg-template.bicep \
  --parameters rgName="$RG_NAME" rgLocation="$RG_LOCATION"

echo "Done. Verifying..."
az group show --name "$RG_NAME" --output table