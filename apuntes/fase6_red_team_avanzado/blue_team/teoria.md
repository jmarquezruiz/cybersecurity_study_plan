# Blue Team - Fase 6: Advanced Detection & Response

## 1. Advanced Threat Hunting

### 1.1 TTP-Based Hunting

```bash
# Buscar técnicas MITRE ATT&CK
# Initial Access
look for suspicious emails, links

# Execution
look for unusual processes

# Persistence
look for new services, cronjobs
```

### 1.2 YARA Rules

```yaml
rule malware_family {
    strings:
        $s1 = "suspicious string" nocase
        $s2 = { 4D 5A 90 00 }
    condition:
        any of them
}
```

### 1.3 Sigma Rules

```yaml
title: Suspicious Process Creation
status: experimental
detection:
    selection:
        Image Endswith:
            - '\\nc.exe'
            - '\\netcat.exe'
    condition: selection
```

---

## 2. threat Intelligence

### 2.1 IOC Feed

```bash
# AlienVault OTX
curl -X GET https://otx.alienvault.com/api/v1/pulses/subscribed

# abuse.ch URLhaus
curl https://urlhaus.abuse.ch/downloads/csv/

# Feodo Tracker
curl https://feodotracker.abuse.ch/downloads/ipblocklist.json
```

### 2.2 TI Integration

```python
# Automatizar IOC lookup
import requests

def check_ip(ip):
    url = f"https://otx.alienvault.com/api/v1/ip/{ip}/general"
    return requests.get(url).json()
```

---

## 3. Memory Forensics

### 3.1 Volatility

```bash
# Profile
volatility -f memdump.raw --profile=Win7SP1x64 pslist

# Malware analysis
volatility -f memdump.raw --profile=Win7SP1x64 malfind
volatility -f memdump.raw --profile=Win7SP1x64 yarascan
```

### 3.2 Lime

```bash
# Lime memory
git clone https://github.com/504ensicsLabs/lime
./lime /path/to/memory
```

---

## 4. Network Forensics

### 4.1 PCAP Analysis

```bash
# Zeek
zeek -r capture.pcap

# Scripts logs
ls *.log

# Analysis
bro-cut -d < connection.log | head
```

### 4.2 NetworkMiner

```bash
# NetworkMiner
networkminer capture.pcap
```

---

## Resumen

| Area | Herramientas |
|------|-------------|
| Hunting | YARA, Sigma |
| CTI | AlienVault, URLhaus |
| Memory | Volatility |
| Network | Zeek, NetworkMiner |

---

## Recursos

- MITRE ATT&CK
- YARA documentation
- Sigma documentation