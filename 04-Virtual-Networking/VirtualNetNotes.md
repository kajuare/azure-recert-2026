# Admin Azure Virtual Networks
 
**Virtual Network (VNet):**
- Definition: The fundamental building block for private networking in Azure. A VNet lets Azure resources (VMs, App Service, AKS, etc.) securely communicate with each other, the internet, and on-premises networks (via VPN Gateway or ExpressRoute). It's logically isolated from other VNets, uses a private IP address space you define (RFC 1918 ranges), and is segmented into subnets. A VNet is scoped to a single subscription and a single region.
## Virtual Network Concepts:
 
**Region:**
- Represents a set of datacenters (deployed within a defined perimeter, connected via a low-latency regional network). A region can contain 1 or more VNets, but a single VNet cannot span multiple regions — cross-region connectivity requires VNet peering (global peering) or Azure Virtual WAN.

**Subnet:**
- A range of IP addresses carved out of the VNet's address space, used to logically segment and secure resources. Resources are deployed into subnets, not directly into the VNet. NSGs and route tables (UDRs) are applied at the subnet level. Azure reserves 5 IP addresses per subnet: network address, default gateway, 2x Azure DNS, and broadcast address — so a /29 (8 IPs) is the smallest usable subnet, giving only 3 usable IPs.

**DHCP:**
- Azure automatically runs DHCP for every subnet and assigns private IPs to NICs (dynamic allocation by default). You can't disable Azure's built-in DHCP; if a fixed address is needed, set the NIC's private IP allocation to Static instead of running your own DHCP server.

**DNS:**
- Azure provides default (platform) DNS resolution via the internal resolver at **168.63.129.16**, which resolves Azure-internal names and forwards public queries. This can be overridden with custom DNS servers configured at the VNet level (on-prem DNS server, custom DNS VM, or Azure DNS Private Resolver) — useful for hybrid name resolution scenarios.

**DDoS:**
- **DDoS Protection Basic** — free, automatically enabled for every public IP in Azure, always-on traffic monitoring and platform-wide mitigation of common network-layer attacks.
- **DDoS Protection Standard/Network Protection** — paid, tuned specifically to the resources in your protected VNets, adds mitigation policies based on application traffic patterns, attack analytics/metrics via Azure Monitor, cost protection guarantee, and access to a Rapid Response support team during an attack.

## Public IP and Private IP:
 
**Public IP:**
- **SKU:** Basic (legacy, retired) vs **Standard** (current default) — Standard is secure by default (closed to inbound traffic unless explicitly allowed by an NSG), supports Availability Zones, and is required for Standard Load Balancer, VPN Gateway, and Application Gateway v2.
- **Allocation:** Dynamic (assigned when resource starts, released when stopped) vs Static (fixed for the resource's lifetime) — Standard SKU public IPs are always static.
- **Tier:** Regional (default) vs Global (used for cross-region load balancing scenarios).
**Private IP:**
- Assigned from the subnet's address range.
- **Allocation:** Dynamic (via Azure's built-in DHCP, default) or Static (manually reserved from the subnet range).
- Used for communication within the VNet, across peered VNets, or over VPN/ExpressRoute to on-premises — never routable over the public internet directly.

## Network Security Groups (NSG):
 
- A stateful packet filter that controls inbound and outbound traffic to Azure resources, applied at the **subnet** level and/or the **NIC** level.
- Each rule has: priority (100–4096, lower number = higher priority), source/destination (IP, service tag, or ASG), port, protocol (TCP/UDP/ICMP/Any), and action (Allow/Deny).
- Default (system) rules exist for both directions: `AllowVNetInBound`, `AllowAzureLoadBalancerInBound`, `DenyAllInBound` (and symmetric outbound rules) — these have the lowest priority and can be overridden by custom rules with a lower priority number.
- When NSGs exist at both subnet and NIC level, **inbound** traffic is evaluated at the subnet first, then the NIC; **outbound** traffic is evaluated at the NIC first, then the subnet. Traffic must be allowed at both levels to pass.

## Application Security Groups (ASG):
 
- Logically groups VMs/NICs by workload role (e.g., "WebServers", "AppServers", "DBServers") so NSG rules can reference the group instead of hardcoded IP addresses/ranges.
- Used as the **source** or **destination** in an NSG rule, simplifying rule management especially in dynamic/autoscaling environments where IPs change frequently.
- Reduces the total number of NSG rules needed and keeps security policy readable and role-based rather than IP-based. Note: source and destination ASGs in the same rule must belong to the same VNet.

## Azure DNS
 
**DNS Hosting:**
- Azure DNS lets you host public DNS zones and manage DNS records using the same credentials, APIs, tools, and billing as other Azure services. It uses Microsoft's global network of authoritative name servers for fast resolution, high availability, and Anycast-based low latency.

**Naming Convention:**
- The **zone** name is the domain itself (e.g., `contoso.com`). **Record set** names are relative to the zone (e.g., a record named `www` in zone `contoso.com` resolves `www.contoso.com`); use `@` for the zone apex/root. Supported record types: A, AAAA, CNAME, MX, NS, PTR, SOA, SRV, TXT, CAA.

**Delegation:**
- To make Azure DNS authoritative for a domain, update the domain's **NS records at the registrar** to point to the four Azure-assigned name servers for that zone. Until delegation is complete, Azure DNS can still be configured but won't actually serve public queries for the domain.

**Record Sets (Max 20):**
- By default, Azure DNS allows up to **20 records per record set**, up to **10,000 record sets per public zone** (raisable via support ticket), and up to **25,000 record sets per private zone**. The NS and SOA record sets at the zone apex (`@`) are created automatically and can't be deleted individually.

## Private DNS Zone:
 
- Provides name resolution for resources **within one or more VNets** without needing to build a custom DNS solution. Not resolvable from the public internet. Supports the same record types as public zones, plus optional **auto-registration** for VMs.

**Private DNS Zone link:**
- A **virtual network link** connects a VNet to a Private DNS Zone, enabling resources in that VNet to resolve records in the zone.
  - **Resolution only** link — VNet can resolve names in the zone but records aren't auto-managed.
  - **Auto-registration** link — VMs deployed in the linked VNet automatically get an A/PTR record created/updated/removed in the zone as they're created, changed, or deleted.
- A single Private DNS Zone can be linked to multiple VNets, and a VNet can be linked to multiple zones.

**/etc/resolv.conf:**
- The Linux DNS resolver configuration file — lists `nameserver` entries and `search` domains used to resolve hostnames. On Azure Linux VMs this is populated automatically to point at Azure's recursive resolver (`168.63.129.16`) unless a custom DNS server is set on the VNet/NIC. Useful for troubleshooting name resolution issues (e.g., confirming which DNS server a VM is actually querying) — a common check during LFCS-style Linux troubleshooting as well as Azure hybrid DNS scenarios.