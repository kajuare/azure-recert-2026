# Backup Options — Comparison (MARS vs MABS)

## Overview
Azure offers two on-premises backup components with different scopes: **MARS** for simple file/folder backup with no separate server, and **MABS** for a fuller-featured backup server supporting VMs, applications, and app-aware snapshots.

## Comparison Table

| Component | Benefits | Limits | Protects | Backup Storage |
|---|---|---|---|---|
| **Azure Backup (MARS) agent** | Backup files/folders on physical or virtual Windows OS; no separate backup server required | Backup 3x per day max; not application aware; file/folder/volume-level restore only; no Linux support | Files, Folders | Recovery Services Vault |
| **Azure Backup Server (MABS)** | App-aware snapshots; full flexibility on backup timing; recovery granularity; Linux support (via Hyper-V/VMware VMs); backup and restore VMware VMs; no System Center license required | Cannot backup Oracle workloads; always requires a live Azure subscription; no tape backup support | Files, Folders, Volumes, VMs, Applications, Workloads | Recovery Services Vault + locally attached disk |

## Key Terms

- **MARS Agent** (Microsoft Azure Recovery Services agent) — lightweight agent installed directly on a Windows machine (physical or VM) for simple file/folder backup, no extra infrastructure needed.
- **MABS** (Microsoft Azure Backup Server) — a dedicated backup server (similar to DPM) that provides application-aware backups and supports a much broader range of workloads than MARS alone.

## Quick Decision Guide

| If you need to... | Use |
|---|---|
| Back up files/folders on a single Windows server, simply | **MARS** |
| Back up VMs, applications, or need app-consistent snapshots | **MABS** |
| Support Linux workloads (via Hyper-V/VMware) | **MABS** |
| Avoid deploying extra backup infrastructure | **MARS** |
| Backup Oracle workloads | ❌ Neither — not supported |

## Lab Log

| Topic | Lab Done? | GitHub Commit | Notes |
|---|---|---|---|
| Backup Options: MARS vs MABS | ☐ | | Deploy MARS agent on a test Windows VM for file/folder backup; if resources allow, stand up a MABS server to compare app-aware backup of a workload (e.g., SQL) |