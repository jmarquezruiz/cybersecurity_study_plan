# Blue Team - Fase 6: Detection & Response Ejercicios

## Ejercicio 1: YARA Rules

### Objetivo
Crear reglas YARA.

### Pasos
```bash
sudo pacman -S yara

# Crear regla
cat > malware.yar <<'EOF'
rule malware {
    strings:
        $s1 = "suspicious"
        $s2 = { 4D 5A 90 00 }
    condition:
        any of them
}
EOF

# Test
yara malware.yar sample
```

### Entregable
Reglas funcionando.

---

## Ejercicio 2: sigma Rules

### Objetivo
Implementar Sigma rules.

### Pasos
```yaml
title: Suspicious Process
status: experimental
detection:
    selection:
        Image Endswith:
            - '\\nc.exe'
    condition: selection
```

```bash
# Convertir a SIEM
sigmac --config splunk --output output.csv rule.yml
```

### Entregable
Reglas convertidas.

---

## Ejercicio 3: Threat Hunting

### Objetivo
Cazar amenazas.

### Pasos
```bash
# Buscar técnicas
# PowerShell unusual
Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-PowerShell/Operational'} | where {$_.Message -match 'downloadstring'}

# Scheduled tasks
Get-ScheduledTask | where {$_.TaskPath -match 'suspicious'}
```

### Entregable
Hallazgos documentados.

---

## Ejercicio 4: IOC Integration

### Objetivo
Integrar IOC feeds.

### Pasos
```bash
# URLhaus
curl https://urlhaus.abuse.ch/downloads/csv/ | head -20

# Script de check
for ip in $(cat iocs.txt); do
    curl https://urlhaus.abuse.ch/host/$ip
done
```

### Entregable
IOCs integrados.

---

## Ejercicio 5: Memory Forensics

### Objetivo
Analizar memory dumps.

### Pasos
```bash
# Volatility
volatility -f memory.raw --profile=Win7SP1x64 pslist
volatility -f memory.raw --profile=Win7SP1x64 netscan

# Buscar indicadores
volatility -f memory.raw --profile=Win7SP1x64 yarascan -Y "suspicious"
```

### Entregable
Análisis completado.

---

## Ejercicio 6: PCAP Analysis

### Objetivo
Analizar tráfico de red.

### Pasos
```bash
# Zeek
zeek -r capture.pcap

# Log analysis
cat *.log | grep suspicious

# Scripts
bro-cut -d < connection.log | awk '$9 > 1000'
```

### Entregable
Análisis funcional.

---

## Ejercicio 7: APT Detection

### Objetivo
Detectar APT activity.

### Pasos
1. Revisar logs de red2. Buscar beaconing
3. Analizar DNS queries4. Look for unusual processes5. Documentar

### Entregable
Reporte APT.

---

## Ejercicio 8: Full Threat Hunt

### Objetivo
Cacería completa.

### Pasos
1. Hipótesis de amenaza
2. Buscar IOCs3. Correlacionar4. Validar5. Documentar

### Entregable
Informe de threat hunting.