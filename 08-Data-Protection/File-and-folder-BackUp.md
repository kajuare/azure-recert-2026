# File and Folder Backup

## Overview
Both **Azure Files** and **On-Premises** file/folder workloads route through a **Recovery Services Vault**, but each path uses a different mechanism to get there.

## Two Paths, One Vault
Azure Files On-Premises
│ │
▼ ▼
Where: Azure Where: On-Premises
What: Azure file share What: Files and folders
│ │
[Configure Backup] [Prepare Infrastructure]
│ │
└──────────► Recovery Services ◄───── MARS Agent ◄── Windows Server
Vault

## Path 1 — Azure Files

| Step | Detail |
|---|---|
| Where is your workload running? | `Azure` |
| What do you want to backup? | `Azure file share` |
| Step | **Configure Backup** → click `Backup` |
| Result | Backup goes **directly** to the Recovery Services Vault — no agent needed, since the file share is already an Azure resource. |

## Path 2 — On-Premises

| Step | Detail |
|---|---|
| Where is your workload running? | `On-Premises` |
| What do you want to backup? | `Files and folders` |
| Step | **Prepare Infrastructure** → click `Prepare Infrastructure` |
| Result | Requires the **MARS Agent** (Microsoft Azure Recovery Services Agent) installed on the **Windows Server** to push file/folder backups up to the vault. |

## Key Term

**MARS Agent** — Microsoft Azure Recovery Services Agent. Installed on an on-premises Windows machine (physical or VM) to enable direct file/folder/system-state backup to a Recovery Services Vault, without needing DPM or MABS as an intermediary.

## Key Takeaway
- **Azure-native sources** (Azure Files) connect to the vault directly — no agent required.
- **On-premises sources** need an agent (MARS) installed locally to bridge the connection to the vault.

