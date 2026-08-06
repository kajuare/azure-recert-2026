# Blob Lifecycle Management

Lifecycle management policies automate access tier transitions and deletion for blobs, based on rules — instead of manually changing a blob's tier one at a time (as covered in the Storage Access Tiers note).

## Core capabilities

- **Policy-based transition** — define rules that automatically move blobs between tiers (Hot → Cool → Archive) based on age or last-modified date.
- **Delete blobs and snapshots** — automatically expire and remove data (and its snapshots) after a defined period.
- **Filtering option** — scope rules to specific blob types, prefixes (paths), or blob index tags, so the policy only applies to the data you intend.
- **Target different types** — apply distinct rules per data type (e.g., logs vs. backups vs. media) within the same storage account.

## Anatomy of a policy (JSON)

```json
{
  "rules": [
    {
      "enabled": true,
      "name": "rule",
      "type": "Lifecycle",
      "definition": {
        "actions": {
          "baseBlob": {
            "tierToCool": {
              "daysAfterModificationGreaterThan": 60
            },
            "tierToArchive": {
              "daysAfterModificationGreaterThan": 180
            },
            "delete": {
              "daysAfterModificationGreaterThan": 365
            }
          }
        },
        "filters": {
          "blobTypes": [
            "blockBlob"
          ]
        }
      }
    }
  ]
}
```

**What this rule does, in order:**
1. `enabled: true` — the rule is active.
2. `tierToCool` — after **60 days** with no modification, move the blob to **Cool**.
3. `tierToArchive` — after **180 days**, move it to **Archive**.
4. `delete` — after **365 days**, delete the blob entirely.
5. `filters.blobTypes: ["blockBlob"]` — this rule only applies to **block blobs** (not append or page blobs).

This gives you a full cost-optimization pipeline: hot data ages out to cheaper tiers automatically, and eventually gets purged — all without manual intervention.

## Exam angle (AZ-104)
- **Time conditions are based on "days after modification" (or "days after creation")** — not access frequency by default. There's also a variant, `daysAfterLastAccessTimeGreaterThan`, but that requires **last access time tracking** to be explicitly enabled on the storage account first (it's off by default, since tracking every read has a small cost).
- **Rule order matters conceptually but not execution priority** — all matching actions within a rule run in the logical order Hot → Cool → Archive → Delete; you can't tier a blob "backward" (e.g., Archive back to Hot) via lifecycle policy — that requires manual rehydration.
- **Filters are optional but scoped tightly**: you can filter by `blobTypes`, `prefixMatch` (path prefix), and `blobIndexMatch` (tag-based) — useful for applying different lifecycles to different "folders" or tagged datasets within one container.
- **Only applies to Block Blobs by default in most real-world rules** — Append and Page blobs (used for VHDs/disks) have different/limited lifecycle behavior, so `blobTypes` filtering is almost always present in real policies.
- **This is a storage-account-level feature**, configured under the account's "Lifecycle management" blade — not something set per-container or per-blob (individual blob tiers, in contrast, are set manually per blob or overridden by lifecycle rules).
- Common exam scenario: *"Automatically reduce storage costs for infrequently accessed logs while retaining them for compliance, then delete after a retention period"* → this is describing exactly this feature.

---
*Study note — Blob Lifecycle Management (AZ-104 recert prep)*