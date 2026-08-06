# Storage Account Types & Replication Options

## Account types quick reference

| Type | Services | Performance tiers | Replication options |
|---|---|---|---|
| Blob storage | Blob | Standard | LRS, GRS, RA-GRS |
| General Purpose V1 | Blob, File, Queue, Table, Disk | Standard, Premium | LRS, GRS, RA-GRS |
| General Purpose V2 | Blob, File, Queue, Table, Disk | Standard, Premium | LRS, ZRS, GRS, RA-GRS, GZRS, RA-GZRS |
| Block blob storage | Blob | Premium | LRS, ZRS |
| File storage | Files | Premium | LRS, ZRS |

**Key takeaway:** only **General Purpose V2** supports the full replication lineup — it's the modern, recommended account type for exactly this reason (plus it supports all four services and both performance tiers).

## Replication options explained

Replication determines how many copies of your data Azure keeps, and where. This is really two separate axes: **local vs. zonal** redundancy, and **regional vs. geo** redundancy — plus an optional **read access** add-on for geo options.

### LRS — Locally Redundant Storage
Keeps **3 copies** of your data within a **single datacenter** in the primary region. Cheapest option.
- Protects against: hardware failures (disk/node/rack failure) within that datacenter.
- Does NOT protect against: an entire datacenter outage (fire, flood, etc.).

### ZRS — Zone-Redundant Storage
Keeps **3 copies** synchronously across **three separate Availability Zones** within the same region.
- Protects against: an entire datacenter (zone) going down — each zone is physically separate with independent power/cooling/networking.
- Does NOT protect against: a region-wide disaster affecting all zones at once.

### GRS — Geo-Redundant Storage
Keeps **3 copies** in the primary region (like LRS) **plus 3 more copies replicated asynchronously to a secondary, paired region** hundreds of miles away.
- Protects against: a full regional outage.
- The secondary region's copies are **not readable** under normal conditions — you can only access them if Microsoft initiates a failover to the secondary region.

### RA-GRS — Read-Access Geo-Redundant Storage
Same as GRS, but you get **read access to the secondary region's data at all times**, via a separate `-secondary` endpoint — even when the primary region is healthy.
- Useful for read-heavy DR scenarios or serving read traffic closer to users in the secondary region.
- Writes still only happen against the primary; the secondary is eventually consistent (there's replication lag).

### GZRS — Geo-Zone-Redundant Storage
Combines **ZRS in the primary region** (3 zone-redundant copies) **+ GRS-style async replication to a secondary region** (3 more copies there via LRS).
- Best of both worlds: zone resilience in the primary region *and* protection against a full regional disaster.

### RA-GZRS — Read-Access Geo-Zone-Redundant Storage
Same as GZRS, but adds **read access to the secondary region's data at all times**, just like RA-GRS does for GRS.
- The highest-durability, highest-availability option available — also the most expensive.

## Side-by-side summary

| Option | Copies | Zone-redundant (primary)? | Geo-redundant (secondary)? | Secondary readable? |
|---|---|---|---|---|
| LRS | 3 (1 datacenter) | No | No | N/A |
| ZRS | 3 (3 zones) | Yes | No | N/A |
| GRS | 3 + 3 | No | Yes | No |
| RA-GRS | 3 + 3 | No | Yes | Yes |
| GZRS | 3 + 3 | Yes | Yes | No |
| RA-GZRS | 3 + 3 | Yes | Yes | Yes |

## Exam angle (AZ-104)
- **"RA-" prefix = Read Access to secondary** — this is the single most important pattern to remember; it applies identically to both GRS and GZRS.
- **ZRS alone does NOT replicate to another region** — it's purely about zone resilience within one region. Don't confuse "zone" with "geo."
- **Failover**: with GRS/RA-GRS/GZRS/RA-GZRS, Microsoft (or you, via customer-managed failover) can fail over to the secondary region if the primary goes down — after failover, the old secondary becomes the new primary.
- **Cost and availability scale together**: LRS is cheapest/least durable; RA-GZRS is priciest/most durable. Exam scenarios about "minimize cost while tolerating X failure type" map directly to picking the *smallest* replication tier that still satisfies the stated failure scenario.
- **Availability SLA differs by replication type** — RA-GRS/RA-GZRS offer higher read availability SLAs than GRS/GZRS specifically because of that always-on secondary read access.
- **GPv2 is the only account type offering ZRS combined with geo-redundancy (GZRS/RA-GZRS)** — Block blob storage and File storage (premium) only go up to ZRS, no geo-redundant options at all, since they're built on premium SSD and geo-replication isn't offered at that performance tier.

---
*Study note — Storage Account Types & Replication Options (AZ-104 recert prep)*