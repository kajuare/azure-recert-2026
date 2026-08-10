
# Comparison of Entra ID Free, P1, P2, and Active Directory on-prem:

| Feature/Concept | Entra ID Free | Entra ID P1 | Entra ID P2 | Active Directory on-prem |
| --- | --- | --- | --- | --- |
| **Cloud-only user password change** | Yes | Yes | Yes | No |
| **Cloud-only user password reset** | No | Yes | Yes | No |
| **Hybrid user password change or reset with on-prem writeback** | No | No | Yes | Yes |
| **Infrastructure apps** | No | No | No | Yes |
| **SaaS apps support** | Yes | Yes | Yes | No |
| **Line of business (LOB) apps with modern authentication** | Yes | Yes | Yes | Yes (with AD FS) |
| **Provisioning: users** | Cloud-based | Cloud-based | Cloud-based | On-premises |
| **Provisioning: external identities** | Managed by Entra B2B | Managed by Entra B2B | Managed by Entra B2B | Manual management |