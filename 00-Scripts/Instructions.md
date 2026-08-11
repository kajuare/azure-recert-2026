# How to run the Scripts from Linux VM or WSL: 

## Make sure you have the AZ module installed:

```bash
# Update your WSL
sudo apt-get update

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# or
sudo apt-get install -y azure-cli

# Verify the Version
az version
```


## Proceed with the login into your account: 


```bash
# Log in if you haven't already
az login

# See which subscriptions you have access to
az account list --output table

# Set the one you want active
az account set --subscription "<subscription-id-or-name>"

# Confirm
az account show --output table
```

## Run the Script:

### Option A:

```bash
# Clone the repo to your local Machine
git clone git@github.com:kajuare/azure-recert-2026.git

# Move to the repo copy
cd azure-recert-2026/scripts

# Modify the Script permissions
chmod +x deploy-rg-arm.sh deploy-rg-bicep.sh

# Finally run the script
./deploy-rg-arm.sh
```
### Option B:

```bash
# Call via Curl the script
curl -sSL https://raw.githubusercontent.com/kajuare/azure-recert-2026/main/scripts/deploy-rg-arm.sh -o deploy-rg-arm.sh

# Modify the Script permissions
chmod +x deploy-rg-arm.sh

# Finally run the script
./deploy-rg-arm.sh
```

## If you want the script to verify the subscription: 

### Add this portion to the top of the script you want. 

```bash
echo "Current subscription:"
az account show --query "{Name:name, ID:id}" --output table
read -p "Proceed with this subscription? (y/n): " CONFIRM
if [ "$CONFIRM" != "y" ]; then
  echo "Aborted. Run 'az account set --subscription <name>' and try again."
  exit 1
fi
```