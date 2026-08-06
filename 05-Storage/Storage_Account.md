# Storage Services

An Azure Storage Account offers four distinct services, each organizing data differently to suit different data shapes and access patterns.

## The four services

| Service | Top-level unit | Contains | Example data |
|---|---|---|---|
| **Azure Containers** (Blob) | Container | Blobs | Documents, Images, Video, Audio, Backup files, Databases, Log files, Big Data |
| **Azure Files** | Files (file share) | Directories | `*.txt`, `*.exe`, `*.*` — any file type, structured in folders |
| **Azure Tables** | Table | Entities | Rows like `Name=Sandy, Country=US, State=TX, ZIP=03445` — key-value/NoSQL data |
| **Azure Queues** | Queue | Messages | `resizeImage`, `cropImage`, `processImage` — small task/work messages |

## What each one is actually for

### Azure Containers (Blob storage)
Unstructured object storage — the "put any file here" service. Backing store for images, video, backups, big data, logs. Same underlying tech that powers static website hosting and data lake storage (via ADLS Gen2 on top of Blob).

### Azure Files
Fully managed **file shares** accessible via the SMB protocol (and NFS for Linux/premium tier) — think of it as a network drive in the cloud. Organizes data with real directories/folders (unlike Blob, where "folders" are just naming conventions). Commonly used to "lift and shift" on-prem file server shares, or as a shared volume mounted by multiple VMs/containers.

### Azure Tables
NoSQL key-value store for **structured, non-relational data**. Each row is an "entity" with a partition key + row key + arbitrary properties (like `Name`, `Country`, `State`, `ZIP` in the example). Good for large volumes of structured data needing fast lookups without the overhead of a relational database.

### Azure Queues
Simple **message queuing** for decoupling application components. Producers drop messages (like `resizeImage`, `cropImage`) into the queue; consumers (e.g., a worker role or Function) pick them up and process them asynchronously — classic pattern for offloading background jobs.

## Exam angle (AZ-104)
- **Blob vs. Files — the classic mix-up**: Blob storage is for unstructured objects accessed via REST/SDK/HTTP; Azure Files is for structured file-share access via SMB/NFS mount, usable like a network drive with a drive letter on Windows or a mount point on Linux.
- **Table storage vs. Cosmos DB**: Azure Table storage is the basic, low-cost NoSQL option; Cosmos DB's Table API is the premium/globally-distributed evolution of the same concept — exam questions testing "cheap and simple vs. globally distributed and feature-rich" often hinge on this distinction.
- **Queue storage vs. Service Bus**: Azure Queues (Storage) are simple, cheap, and good for basic FIFO-ish task queues; Service Bus Queues are the more advanced, enterprise-tier alternative supporting features like sessions, dead-lettering, and topics/subscriptions (pub-sub). Know which one a scenario is asking for based on complexity requirements.
- **All four services live under one Storage Account** — you don't provision them separately; a single storage account name gives you all four endpoints (`blob`, `file`, `table`, `queue`) simultaneously, as covered in the Accessing Storage Endpoints note.

---
*Study note — Storage Services (AZ-104 recert prep)*