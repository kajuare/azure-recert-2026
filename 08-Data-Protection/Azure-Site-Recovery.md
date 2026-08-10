# Azure Site Recovery (ASR)

## Definition
Azure Site Recovery is Azure's **disaster recovery (DR) as a service** offering. It keeps applications and workloads running by continuously replicating them to a secondary location (a different Azure region, or Azure itself as the target for on-prem workloads), and orchestrates failover/failback when the primary site is unavailable.

This is item **05** from the original module index — the last of the 5 topics.

## Core Concept

Unlike Azure Backup (which protects against **data loss**), Azure Site Recovery protects against **site/region unavailability** — its goal is business continuity, keeping workloads running with minimal downtime, not just recovering files.

| | Azure Backup | Azure Site Recovery |
|---|---|---|
| **Protects against** | Data loss / corruption | Site or region outage |
| **Goal** | Recover data/files/VMs to a point in time | Keep the application running with minimal downtime |
| **Key metric** | RPO (Recovery Point Objective) | RTO (Recovery Time Objective) + RPO |
| **Typical use** | Restore a deleted file, corrupted VM disk | Failover an entire VM/app to another region during an outage |

## Supported Scenarios

| Source | Target |
|---|---|
| Azure VMs (Region A) | Azure VMs (Region B) |
| On-premises VMware VMs | Azure |
| On-premises Hyper-V VMs | Azure |
| On-premises physical servers | Azure |

## Key Terms

- **Replication** — continuous copying of VM disk changes to the target region/site, so a near-current copy always exists.
- **Failover** — the process of switching workloads to run from the secondary (target) location when the primary is down.
- **Failback** — switching workloads back to the primary location once it's available again.
- **Recovery Plan** — an orchestration sequence (order, scripts, dependencies) that defines *how* multiple VMs/apps fail over together — e.g., database before app server.
- **RPO (Recovery Point Objective)** — maximum acceptable amount of data loss, measured in time (e.g., "5 minutes of data loss max").
- **RTO (Recovery Time Objective)** — maximum acceptable time to restore service after a disaster.

## High-Level Flow

```mermaid
flowchart LR
    A["Primary Site<br/>(On-prem or Azure Region A)"] -->|Continuous Replication| B["Recovery Services Vault"]
    B -->|Failover| C["Secondary Site<br/>(Azure Region B)"]
    C -->|Failback (once primary recovers)| A
```

## Where It Fits in the Vault

Just like Azure Backup, Azure Site Recovery uses a **Recovery Services Vault** — but the vault's role here is to store replication configuration and orchestrate failover/failback, not to store recovery points of files.

