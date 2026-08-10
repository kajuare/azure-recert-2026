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

## Mini-lab per each block: 

**1. Entra ID Fundamentals (concepts + ediciones + Entra ID vs AD)**


**2. Gestión de usuarios (User Accounts + Bulk Operations)**
- Crea 5-10 usuarios de prueba vía **Azure CLI** (`az ad user create`) y documenta los comandos
- Crea el mismo set pero vía **bulk import CSV** (exporta la plantilla del portal, llénala, súbela)
- Script en Bash o PowerShell que automatice la creación desde un CSV
- Commit: `02-user-management/` con el script + el CSV de ejemplo + notas

**3. Group Accounts**
- Crea grupos de seguridad y M365, uno estático y uno con **membresía dinámica** (regla tipo `user.department -eq "IT"`)
- Documenta la regla dinámica usada y por qué
- Commit: `03-dynamic-groups.md`

**4. Device Identities**
- Si tienes un tenant de prueba, documenta los 3 tipos (Entra joined, Entra hybrid joined, Entra registered) con diagrama simple (puedo generarte uno)
- Si no tienes dispositivos reales para unir, documenta el flujo conceptual + comandos de `dsregcmd /status` (puedes correrlo en tu propia laptop si es Windows)
- Commit: `04-device-identities.md`

**5. SSPR (Self-Service Password Reset)**
- Habilita SSPR en tu tenant, configura métodos de autenticación
- Documenta el flujo de configuración paso a paso con screenshots
- Commit: `05-sspr-setup.md`

**6. Multi-tenant environments**
- Documento conceptual: cuándo usarías multi-tenant vs single-tenant, cross-tenant access settings
- Si tienes 2 tenants de prueba, intenta una configuración básica de cross-tenant sync/access
- Commit: `06-multitenant-notes.md`

¿Quieres que te arme la estructura de carpetas completa para `azure-recert-2026` y te genere ya los scripts base (CLI + PowerShell) para el lab de usuarios y grupos dinámicos, para que solo los corras y commitees?