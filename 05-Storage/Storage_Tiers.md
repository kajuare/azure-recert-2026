# Storage Access Tiers

Access tiers let you optimize blob storage cost based on how frequently the data is accessed — the tradeoff is always **storage cost vs. access/retrieval cost**, moving inversely to each other.

## The three tiers

| Tier | Storage Cost | Access Cost |
|---|---|---|
| **Hot** | $$$ (highest) | $ (lowest) |
| **Cool** | $$ (medium) | $$ (medium) |
| **Archive** | $ (lowest) | $$$ (highest) |

### Hot
For data accessed **frequently**. Highest storage cost, lowest cost per read/write — optimized for active workloads (e.g., a website's live images, an app's active data).

### Cool
For data accessed **infrequently**, but still needs to be available immediately when needed. Lower storage cost than Hot, but you pay more per access — good for short-term backups or data not touched daily but occasionally needed. Requires a **minimum storage duration of 30 days** (early deletion incurs a penalty fee).

### Archive
For data that's **rarely accessed** and can tolerate hours of retrieval latency. Cheapest storage cost by far, but highest access cost and — critically — **data isn't immediately readable**. You must first **rehydrate** the blob (move it back to Hot or Cool) before reading it, which can take **hours** depending on the rehydration priority (Standard vs. High). Requires a **minimum storage duration of 180 days**.

## Changing tiers (portal)

From the diagram: right-click a blob → **Change tier** → pick **Hot**, **Cool**, or **Archive** from the dropdown.

- **"Hot (Inferred)"** in the screenshot means the blob doesn't have an explicit tier set on it directly — it's just inheriting the storage account's default access tier (which is Hot in this case). Once you manually set a tier on a blob, it's no longer "inferred" — it becomes explicit and overrides the account default.

## Exam angle (AZ-104)
- **Default access tier is set at the storage account level** (Hot or Cool) — individual blobs can override it. A blob without an explicit tier shows as "(Inferred)" and follows whatever the account default is.
- **Archive tier is offline** — you cannot read or modify an archived blob directly; you must rehydrate it first via **"Set blob tier"** (or `az storage blob copy` to a new blob), and rehydration has two priority options:
  - **Standard** — up to 15 hours.
  - **High** — under 1 hour, for smaller blobs, at extra cost.
- **Early deletion penalties**: moving/deleting a blob before its minimum retention period ends triggers a pro-rated early deletion fee — Cool (30 days minimum), Archive (180 days minimum). Hot has no minimum.
- **Lifecycle management policies** automate tier transitions (e.g., "move to Cool after 30 days of no access, move to Archive after 90 days, delete after 365 days") — this is the AZ-104-relevant way to apply tiering at scale instead of manually changing tiers blob by blob.
- **Tiering only applies to Blob storage** (specifically Block Blobs) — it does not apply to Files, Queues, or Tables.

---
*Study note — Storage Access Tiers (AZ-104 recert prep)*