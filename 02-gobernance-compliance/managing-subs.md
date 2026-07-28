# Sub types:

- Enterprice Agreements. 
- Pay-as-you-go.
- Cloud Solution Provider. 
- Free trial (To test or learning purposes).
- Azure for students. 
- Visual Studio. 

# Hierarchy:

- Management Groups (Tenant).
    Subscriptions
        Resource Groups
            Resources

# Azure Resource Hierarchy

Azure resources are organized in a four-level hierarchy, from broadest to most specific scope:

1. **Management Groups** — group multiple subscriptions (tenant-wide)
2. **Subscriptions** — billing and access boundary
3. **Resource Groups** — logical container for related resources
4. **Resources** — the actual services (VMs, storage, etc.)

- Example:
    Root Management Group 
        IT
            Production
                SubScription A
            Develop
                Subscription B
        Finance
                Subscription C

Root Management Group
├── IT
│ ├── Production
│ │ └── Subscription A
│ └── Development
│ └── Subscription B
└── Finance
└── Subscription C

# Azure Resource Tags:

- Use to simplify tasks:
    Monitoring.
    Automation.
    Reporting.
    Cost Traking.

- Add metadata to a resouce:
 Example you add Owner user-name and department tag to identify a single reosurce or multiple.

- Tags are not inherited unless you apply a policy. 

# Azure locks:

They are inmherited tot he lower scopes. 
Read-only Locks: can not be modified will prevent any changes. 
Delete Lock: Just prevent deletion of the resources. 

# Manage Costs:

- Cost analysis:
    Shows in graphs where your mony is going. 
- Budget and Recomendations:
    Set spending limits and recomendations (advisor). 
- Export Data: 
    Allow download data.

# Azure Policy:

Definition, Scope, Assignment, Compliance. 

- Definition: Json Doc to define policy and effects. 
- Scope: Group, Subscription or Resource Group. 
- Assignment: process of assigning policy to Scope. 
- Compliance: Porcess to evaluate if resource is compliant or non-compliant. 

**Initiatives:** are a conjunction of policies working together. 

**Policy Examples:**
- Requiere tags: 
    Enforce Tags.
- Inherit tags:
    Enforece to inherit tags froim Subs or RG. 
- Allowed Locations: 
- Allowed VM SKUs:
- Allowed RG Locations: 
- Allowed Resoruce Types: 

# Role-base Access Control RBAC:

**To:** Enable access to specific resoruces and segregate dutties with the team. 

- who?: Security Principal. 
- What?: Role Definition. 
- Where?: Scope. 

**Who+What+Wher=** Assignment: Role Assignment. 

- There are Built-in and Custom Roles. 

**Built-in Roles:**
- Owner: Full access and can delegate access to other users. 
- Contributor: Manage full the resoruces but can not grant permissions to others. 
- Reader: Only read, can not perform changes. 
- User Access Admin: Provide access to others, but do not-can't manage resoruces.

** The scope of the role will be inherited downwards, so if you assign a role over the Resoruce group, user will have same access to the resoruces. **

# Azure RBAC Vrs Entra ID Roles: 

| | Azure RBAC | Microsoft Entra ID Roles |
|---|---|---|
| **Purpose** | Manage access to Azure resources | Manage Microsoft Entra ID features |
| **Scope** | Management groups, Subscriptions, Resource Groups, Resources | Microsoft Entra ID tenant level |
| **Management tools** | Azure Portal, Azure PowerShell, Azure CLI, ARM templates, REST API | Azure Portal, M365 Admin Portal, Microsoft Graph API, Microsoft Entra ID, Graph PS module |
| **Example roles** | Owner, Contributor, Reader, User Access Administrator | Global Administrator, Billing Administrator, Global Reader |

