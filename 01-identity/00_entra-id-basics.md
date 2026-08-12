# Microsoft Entra ID — Core Concepts

2026-07-27 | Re-certifying (originally certified AZ-104 in 2020, now expired)

## Topics covered
- Entra ID concepts & editions (Free/P1/P2)
- Entra ID vs Active Directory Domain Services (AD DS)
- Device identity configuration
- User accounts & bulk operations
- Group accounts
- Self-service password reset (SSPR)
- Multi-tenant environments

# How to review the Microsoft Endtra ID License time: 

## Portal: 

- Go to the Up search Bar and just type Microsoft Entra ID. 
- In the Overview section, look for the **"License:"** option, there you will se your lince type 

## CLI: 

- There is no command that will show that info, just tenatn and Sub ID details. 
    Command Example: 

```bash    
az account show --query "{TenantId:tenantId, SubscriptionId:id, SubscriptionName:name}" -o table
```

