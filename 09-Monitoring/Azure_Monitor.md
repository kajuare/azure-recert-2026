# Azure Monitor

## Overview

Azure Monitor is the unified platform for collecting, analyzing, and acting on telemetry from Azure, other clouds, and on-premises environments. It follows a four-stage pipeline:

**Data Sources → Collection/Routing/Transform → Data Platform → Consumption**

---

## 1. Data Sources

What can feed data into Azure Monitor:

| Category | Examples |
|---|---|
| Apps / Workloads | Custom Apps, IaaS Workloads |
| Infrastructure | Containers, Operating System |
| Azure Platform | Azure Resources, Azure Subscription, Azure Tenant |
| Custom Sources | Custom Resources (via API) |

Sources can originate **In Azure**, in **Other Clouds**, or **On-Premises**.

---

## 2. Data Collection, Routing, and Transform

How telemetry is ingested and routed into Azure Monitor:

- **App SDK** — Application Insights instrumentation, embedded in app code
- **Agent(s)** — primarily **Azure Monitor Agent (AMA)**, the modern unified agent (replaces legacy Log Analytics / Diagnostics agents)
- **DCR (Data Collection Rules)** — defines *what* data gets collected and *where* it's routed. Central concept for AMA-based collection.
- **Diagnostic Settings** — routes Azure platform logs/metrics (e.g. Activity Log, resource logs) to a destination (Log Analytics, Storage, Event Hub)
- **Zero Config** — signals collected automatically with no setup (e.g. platform metrics)
- **API** — for custom/programmatic ingestion

>  **Exam note:** DCRs are the modern way to configure AMA data collection. Know the difference between Diagnostic Settings (platform logs/metrics → destination) and DCRs (agent-based collection rules).

---

## 3. Data Platform

The four pillars of data stored inside Azure Monitor:

| Pillar | Description |
|---|---|
| **Metrics** | Numeric time-series data |
| **Logs** | Stored in a Log Analytics Workspace, queried with KQL |
| **Traces** | Distributed tracing data, mainly from Application Insights |
| **Changes** | Resource/config change history (Change Analysis) |

---

## 4. Consumption

What you can do with the collected data:

### Insights
Prebuilt monitoring views for specific resource types:
- Application Insights
- Container Insights
- VM Insights
- Network Insights

### Visualize
- Workbooks
- Dashboards
- Power BI
- Grafana

### Analyze
- **Metrics Explorer** — chart/inspect metric data
- **Log Analytics** — query logs with KQL
- **Change Analysis** — diagnose issues caused by resource changes

### Respond
- **AIOps** — AI-driven anomaly detection/insights
- **Alerts & Actions** — alert rules, action groups
- **Autoscale** — scale resources based on metrics

---

## SCOM Managed Instance (side track)

For hybrid orgs migrating on-prem System Center Operations Manager (SCOM) to Azure:

```
SCOM MI Agent → Mgmt Server → SQL Databases → Ops Console / Power BI
```

Niche for AZ-104 but useful to recognize — bridges legacy on-prem monitoring into the Azure ecosystem.

---

## Integrate

Azure Monitor data can be exported/automated via:

- Event Hubs
- Azure Storage
- Managed Partners
- Import / Export APIs
- Logic Apps
- Functions
- Azure DevOps
- GitHub

---

## Quick Recall Table

| Stage | Key Components |
|---|---|
| Data Sources | Apps, Infrastructure, Azure Platform, Custom |
| Collection | App SDK, Agent(s), DCR, Diagnostic Settings, Zero Config, API |
| Data Platform | Metrics, Logs, Traces, Changes |
| Consumption | Insights, Visualize, Analyze, Respond |

---

## Related Exam Topics
- [ ] Configure Diagnostic Settings on a resource
- [ ] Create and assign a Data Collection Rule (DCR)
- [ ] Deploy Azure Monitor Agent (AMA)
- [ ] Build a basic KQL query in Log Analytics
- [ ] Create a metric-based alert rule + action group
- [ ] Configure autoscale on a VM Scale Set / App Service Plan

---
