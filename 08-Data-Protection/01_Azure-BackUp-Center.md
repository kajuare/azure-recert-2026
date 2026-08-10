## Backup Center — Navigation Structure

**Manage**
- **Backup instances** — individual protected items (e.g., specific VMs, file shares).
- **Backup policies** — schedule/retention rules applied to backups.
- **Vaults** — Recovery Services vaults and Backup vaults across the environment.

**Monitoring + reporting**
- **Backup jobs** — status of scheduled/on-demand backups and restores.
- **Backup reports** — historical and trend reporting on backup activity.

**Policy and compliance**
- **Backup compliance** — checks whether resources meet defined backup policy requirements.
- **Azure policies for backup** — built-in/custom Azure Policy definitions to enforce backup governance.
- **Protectable datasources** — resources eligible for backup that aren't yet protected.

**Support + troubleshooting**
- **New support request** — direct path to open a Microsoft support case.

## Example Dashboard View (Datasource type: Azure Virtual Machines)

**Jobs (last 24 Hours)**

| Operation | Failed | In progress | Completed |
|---|---|---|---|
| Scheduled backup | 0 | 0 | 2 |
| On-demand backup | 0 | 0 | 0 |
| Restore | 0 | 0 | 0 |

**Backup instances — Azure Virtual Machines**

| Metric | Count |
|---|---|
| Protection configured | 2 |
| Protection stopped | 0 |
| Soft deleted | 0 |
| Datasource not found | 0 out of 2 |

