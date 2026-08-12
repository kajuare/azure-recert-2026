#!/bin/bash
set -e

# Prompt user for input
read -p "Enter the Resource Group name: " RG_NAME
read -p "Enter the location (e.g. eastus, westeurope): " RG_LOCATION

# Create ARM template on the fly
cat > rg-template.json << EOF
{
  "\$schema": "https://schema.management.azure.com/schemas/2019-08-01/subscriptionDeploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "rgName": { "type": "string" },
    "rgLocation": { "type": "string" }
  },
  "resources": [
    {
      "type": "Microsoft.Resources/resourceGroups",
      "apiVersion": "2021-04-01",
      "name": "[parameters('rgName')]",
      "location": "[parameters('rgLocation')]"
    }
  ]
}
EOF

echo "Deploying Resource Group '$RG_NAME' in '$RG_LOCATION' using ARM..."

az deployment sub create \
  --name "createRg-$RG_NAME" \
  --location "$RG_LOCATION" \
  --template-file rg-template.json \
  --parameters rgName="$RG_NAME" rgLocation="$RG_LOCATION"

echo "Done. Verifying..."
az group show --name "$RG_NAME" --output table

