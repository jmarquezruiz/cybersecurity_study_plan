# Red Team - Fase 7: Bug Bounties & Profesionalización

## 1. Bug Bounty Platforms

### 1.1 Principales Plataformas

| Platform | Descripción |
|----------|--------------|
| HackerOne | Mayor programa, Fortune 500 |
| Bugcrowd | Primera plataforma |
| Intigriti | Europea, programas elite |
| OpenBugBounty | Open source focused |
| YesWeHack | Francesa |

### 1.2 Programas

- **Public programs**: Anyone can hunt
- **Private programs**: Invitation only
- **VDP**: Vulnerability Disclosure Program

---

## 2. Bug Bounty Workflow

### 2.1 Reconnaissance

```bash
# Subdomain enumeration
subfinder -d target.com

# Port scanning
nmap -p- target.com

# Services
nmap -sV target.com

# Technology detection
whatweb target.com
wappalyzer target.com
```

### 2.2 Fuzzing

```bash
# Dictionaries
ffuf -w wordlist.txt -u https://target.com/FUZZ

# Parameters
paraminer target.com
```

### 2.3 Reporting

```markdown
## Title
[Title descriptivo]

## Steps to Reproduce
1. Step one
2. Step two
3. Step three

## Impact
[Descripción del impacto]

## Evidence
[Screenshots, payloads]
```

---

## 3. Profesionalización

### 3.1 Pentest Report Template

```markdown
# Executive Summary
[Visión general]

# Scope
[Alcance definido]

# Methodology
[Metodología usada]

# Findings
[Hallazgos por severidad]

# Recommendations
[Recomendaciones]

# Appendix
[Comandos, logs]
```

### 3.2 Communication

- Be clear and concise
- Provide reproducible steps
- Show business impact
- Be professional

---

## 4. Recon Techniques

### 4.1 Subdomain Enumeration

```bash
# Passive
subfinder -d target.com
amass enum -passive -d target.com

# Active
dnsenum target.com
fierce -domain target.com
```

### 4.2 Content Discovery

```bash
# Fuzzing
ffuf -w wordlist.txt -u https://target.com/FUZZ -mc 200,204,301,302,307,401,403

# Wayback
waybackurls target.com
```

---

## 5. Escalation

### 5.1 From XSS to Account Takeover

1. Identify stored XSS
2. Find session token location
3. Steal cookies via XSS
4. Escalate to account takeover

### 5.2 From SSRF to Cloud Metadata

1. Identify SSRF
2. Access cloud metadata
3. Retrieve credentials
4. Pivot

---

## 6. Best Practices

| Práctica | Descripción |
|----------|--------------|
| Read scope | Solo lo que está en scope |
| No automation | En programas con reglas |
| Minimum impact | No DoS |
| Ethical | Follow rules |
| Patient | Wait for response |

---

## Recursos

- HackerOne Program Listings
- Bugcrowd Resources
- PayloadsAllTheThings
- Web Security Academy