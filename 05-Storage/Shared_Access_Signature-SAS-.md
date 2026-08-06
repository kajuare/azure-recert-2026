# Shared Access Signature (SAS)

A SAS is a **URI-based token** that grants scoped, time-limited access to storage resources — without sharing your account key or Azure AD credentials. It's essentially a signed URL: anyone with the URL gets exactly the access defined in its parameters, nothing more.

## Anatomy of a SAS URI

**Full example:**
```
https://kodekloud.blob.core.windows.net?sv=2020-08-04&ss=bftq&srt=sc&sp=rwdlacup&st=2022-05-19T06:31:40Z&se=2022-05-19T14:31:40Z&sip=168.11.12.13-168.11.12.19&spr=https&sig=66iXqzZSakarJO5J210%2ByoPRVXTeT%2FTJcHHSEkUjHr0%3D
```

| Parameter | Excerpt | Meaning |
|---|---|---|
| **Resource URI** | `https://kodekloud.blob.core.windows.net` | The blob endpoint being accessed. |
| **sv** — Storage service version | `sv=2020-08-04` | Which version of the storage REST API this SAS was signed against. |
| **ss** — Services | `ss=bftq` | Which services the SAS applies to: **b**lob, **f**ile, **t**able, **q**ueue. |
| **srt** — Resource type | `srt=sc` | Scope of operations: **s**ervice-level, **c**ontainer-level (also `o` for object/blob-level). |
| **sp** — Permissions | `sp=rwdlacup` | Allowed actions: **r**ead, **w**rite, **d**elete, **l**ist, **a**dd, **c**reate, **u**pdate, **p**rocess. |
| **st** — Start time | `st=2022-05-19T06:31:40Z` | When the SAS becomes valid (UTC). |
| **se** — End time | `se=2022-05-19T14:31:40Z` | When the SAS expires (UTC) — after this, the URL stops working entirely. |
| **sip** — IP address range | `sip=168.11.12.13-168.11.12.19` | Restricts usage to requests coming from this IP range only. |
| **spr** — Protocol | `spr=https` | Restricts to HTTPS-only requests (can also allow `https,http`). |
| **sig** — Signature | `sig=66iXqzZ...` | The actual cryptographic proof: an HMAC computed over a "string to sign" (built from all the other parameters) using the account key, hashed with SHA-256, then Base64-encoded. This is what makes the URL tamper-proof — change any parameter and the signature no longer validates. |

## Why the signature matters

The `sig` value is what makes a SAS secure: it's generated using your storage account key, so anyone with the SAS URL **cannot forge or modify** any of the other parameters (permissions, expiry, IP range) without invalidating the signature. This is also why a SAS is only as secure as the account key used to sign it — if the key is regenerated, all SAS tokens signed with it become invalid immediately.

## Types of SAS (for context beyond this diagram)

- **Account SAS** — grants access to one or more storage services (Blob, File, Table, Queue) at the account level — what this diagram's example represents (`ss=bftq`).
- **Service SAS** — scoped to a single service (e.g., just Blob), delegated by the account key.
- **User Delegation SAS** — the most secure option; signed with **Azure AD credentials** instead of the storage account key, so it doesn't depend on account key rotation and integrates with RBAC.

## Exam angle (AZ-104)
- **Expiration (`se`) is the single most important security control** — a SAS with no end time or a far-future expiry is a major risk; best practice is short-lived SAS tokens.
- **`sip` (IP restriction) and `spr` (protocol restriction)** are optional hardening parameters — a question about "restrict SAS access to a corporate network only" points directly at `sip`.
- **Revoking a SAS**: since a SAS isn't tied to a specific identity, you can't revoke an individual token directly (short of Stored Access Policies) — the nuclear option is **regenerating the storage account key**, which invalidates *all* SAS tokens signed with that key at once.
- **Stored Access Policies** let you define permissions/expiry server-side on a container, then issue SAS tokens referencing that policy — this allows you to revoke or modify access for all associated SAS tokens by changing the policy, without needing to regenerate account keys.
- **User Delegation SAS is the preferred modern approach** for the exam's "most secure" scenarios, since it avoids storing/distributing the account key altogether and ties access to Azure AD identity + RBAC.
- Know the letter codes cold: **ss** = services, **srt** = resource type, **sp** = permissions, **st/se** = start/end time, **sip** = IP range, **spr** = protocol, **sig** = signature. These show up often in CLI/PowerShell SAS-generation questions.

---
*Study note — Shared Access Signature (AZ-104 recert prep)*

                                                   1