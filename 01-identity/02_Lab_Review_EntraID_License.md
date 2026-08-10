

# How to review the Microsoft Endtra ID License time: 

## Portal: 

- Go to the Up search Bar and just type Microsoft Entra ID. 
- In the Overview section, look for the **"License:"** option, there you will se your lince type 

## CLI: 
- There is no command that will show that info, just tenatn and Sub ID details. 
    Command Example: az account show --query "{TenantId:tenantId, SubscriptionId:id, SubscriptionName:name}" -o table