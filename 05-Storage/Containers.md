# Creating Containers (Azure Blob Storage)

## Hierarchy

Azure Blob Storage follows a strict 3-level hierarchy:

```
Storage Account → Container → Blob
```

**Example from diagram:**
- **Storage Account:** `webfiles`
- **Containers:** `Documents`, `Videos`
- **Blobs:**
  - `Documents` → `Document1.pdf`, `Document2.pdf`
  - `Videos` → `IntroVideo.mp4`

A **container** is like a top-level folder/bucket inside a storage account (there's no true nested folder structure in blob storage — "folders" you see in the portal are just `/` characters in blob names, simulating a path). A **blob** is the actual file/object stored.

## Creating a container (portal walkthrough)

From the diagram's portal screenshot: `Home > kodekloud (storage account) > + Container > New container`

- **Name** — must be lowercase, no spaces (e.g., `webfiles`).
- **Public access level** — controls anonymous access to the container's contents:

| Access level | What it allows |
|---|---|
| **Private (no anonymous access)** | Default. No anonymous access at all — access requires auth (account key, SAS token, Azure AD/Entra ID). |
| **Blob (anonymous read access for blobs only)** | Anyone with the direct blob URL can read that specific blob, but can't list all blobs in the container. |
| **Container (anonymous read access for containers and blobs)** | Anyone can read blobs AND list all blobs in the container (enumerate contents). |

## The three icons (from diagram)

- **Private** — locked folder icon; no public access, auth required for everything.
- **Blob** — anonymous read on individual blobs only (must know/have the exact URL).
- **Container** — anonymous read on blobs *and* the ability to list/browse the container's contents.

## Exam angle (AZ-104)
- **Public access level is set per-container**, not per storage account — different containers in the same storage account can have different access levels.
- **Default is Private** — a common exam trap is assuming new containers are publicly readable; they aren't unless explicitly set.
- Since 2021, **Azure disables "Allow Blob public access" at the storage account level by default** for new accounts — even if a container is set to Blob/Container access level, the storage account setting can override and block it. Both need to align for public access to actually work.
- **Container-level anonymous access is *not the same* as RBAC/Azure AD access** — public access level governs *anonymous* (unauthenticated) access; RBAC/SAS tokens/account keys govern *authenticated* access and work regardless of the public access level setting.
- **"Blob" vs "Container" access level** — remember: Blob = read individual files if you know the URL; Container = read + list/enumerate everything, which is a bigger exposure (e.g., don't use Container access level for anything with sensitive filenames, since names themselves become discoverable).

---
*Study note — Creating Containers / Blob Storage (AZ-104 recert prep)*