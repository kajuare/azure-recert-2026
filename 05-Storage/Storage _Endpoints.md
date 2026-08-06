# Accessing Storage Endpoints

Every storage service within a storage account gets its own unique, predictable endpoint URL based on the storage account name and the service type.

## Endpoint format

```
<protocol>://<storage account name>.<service>.core.windows.net
```

- **protocol** — `http` or `https`
- **storage account name** — globally unique name you chose (e.g., `kodekloud`)
- **service** — `blob`, `queue`, `file`, or `table`

## Example: storage account "kodekloud"

| Service | Endpoint |
|---|---|
| Container service (Blob) | `https://kodekloud.blob.core.windows.net` |
| Queue service | `https://kodekloud.queue.core.windows.net` |
| File service | `https://kodekloud.file.core.windows.net` |
| Table service | `https://kodekloud.table.core.windows.net` |

## Custom domains

By default you're stuck with the `*.core.windows.net` domain, but you can map your own custom domain via a **CNAME DNS record** pointing to the storage endpoint.

**Example:**

| DNS CNAME entry | Alias (points to) |
|---|---|
| `blobs.kodekloud.com` | `kodekloud.blob.core.windows.net` |

This lets users access blobs via `blobs.kodekloud.com` instead of the default Azure domain — useful for branding or when an app expects a specific hostname.

## Exam angle (AZ-104)
- The **four core services** — Blob, Queue, File, Table — each get a distinct subdomain, but they all live under the **same storage account**. One storage account name reserves all four subdomains simultaneously (which is why storage account names must be globally unique across all of Azure).
- **Custom domain mapping only works for the Blob service** (via CNAME) — you can't currently do this for Queue, File, or Table endpoints.
- **CNAME mapping has a catch with HTTPS**: a plain CNAME-mapped custom domain doesn't support HTTPS directly unless you also configure **Azure CDN or Azure Front Door** in front of it (or use "Secure custom domain" via subdomain validation) — a common gotcha in exam scenarios asking about secure custom domains for blob storage.
- Know the **direct correlation**: Container service in the portal UI = **Blob service** in the endpoint naming (`*.blob.core.windows.net`) — the diagram's table header says "Container service" but the URL literally uses `blob`, since containers/blobs both live under the Blob service.

---
*Study note — Accessing Storage Endpoints (AZ-104 recert prep)*