# Blue Team - Fase 3: Detección de Escalada Ejercicios

## Ejercicio 1: Detección de SUID

### Objetivo
Implementar detección de binarios SUID.

### Pasos
```bash
# Crear baseline
sudo find / -perm -4000 2>/dev/null | sort > ~/baseline_suid.txt

# Crear script de detección
cat > /tmp/check_suid.sh <<'EOF'
#!/bin/bash
CURRENT=$(sudo find / -perm -4000 2>/dev/null | sort)
BASELINE=$(cat ~/baseline_suid.txt)
DIFF=$(diff <(echo "$BASELINE") <(echo "$CURRENT"))
if [ -n "$DIFF" ]; then
    echo "ALERT: SUID binaries changed"
    echo "$DIFF" | mail -s "SUID Alert" security@example.com
fi
EOF

chmod +x /tmp/check_suid.sh
sudo crontab -l 2>/dev/null | { cat; echo "0 * * * * /tmp/check_suid.sh"; } | sudo crontab -
```

### Entregable
Script y baseline creado.

---

## Ejercicio 2: Monitorización de Cron

### Objetivo
Monitorear cambios en cronjobs.

### Pasos
```bash
# Baseline
sudo crontab -l > ~/baseline_cron.txt
cat /etc/crontab > ~/baseline_system_cron.txt
ls -la /etc/cron.d/ > ~/baseline_cron_d.txt

# Script alertas
cat > /tmp/check_cron.sh <<'EOF'
#!/bin/bash
if ! sudo crontab -l 2>/dev/null | diff -q ~/baseline_cron.txt - >/dev/null 2>&1; then
    echo "Cron changed" | mail -s "Cron Alert" admin@example.com
fi
EOF

# Con auditd
sudo auditctl -w /etc/crontab -p wa -k cron_mod
sudo auditctl -l
```

### Entregable
Alertas configuradas.

---

## Ejercicio 3: Detección de Persistence

### Objetivo
Detectar técnicas de persistencia.

### Pasos
```bash
# Linux persistence
sudo crontab -l
cat /etc/crontab
ls -la /etc/cron.d/
systemctl list-units --type=service
cat ~/.bashrc | tail -10

# auditd rules
sudo auditctl -w /etc/crontab -p wa -k cron_mod
sudo auditctl -w ~/.bashrc -p wa -k bashrc_mod

# Detectar ejecutables en startup
ls -la /etc/rc.local
ls -la /etc/profile.d/
```

### Entregable
Reporte de persistencia.

---

## Ejercicio 4: Network Monitoring

### Objetivo
Monitorear conexiones de red.

### Pasos
```bash
# Baseline de conexiones
ss -tulpn > ~/baseline_network.txt

# Script monitoreo
cat > /tmp/check_network.sh <<'EOF'
#!/bin/bash
CURRENT=$(ss -tulpn)
BASELINE=$(cat ~/baseline_network.txt)
if [ "$CURRENT" != "$BASELINE" ]; then
    echo "New connections detected"
    diff <(echo "$BASELINE") <(echo "$CURRENT")
fi
EOF

# Monitoreo continuo
sudo tcpdump -i eth0 -w /tmp/network.pcap &
```

### Entregable
Baseline y script funcionando.

---

## Ejercicio 5: Rootkit Detection

### Objetivo
Detectar rootkits.

### Pasos
```bash
# Instalar rkhunter
sudo pacman -S rkhunter

# Configurar
sudo rkhunter --check

# Configurar daily check
sudo crontab -l 2>/dev/null | { cat; echo "0 3 * * * sudo rkhunter --check"; } | sudo crontab -

# Instalar chkrootkit
sudo pacman -S chkrootkit
sudo chkrootkit
```

### Entregable
Alertas de rootkit.

---

## Ejercicio 6: AIDE Setup

### Objetivo
Configurar AIDE para integridad.

### Pasos
```bash
# Instalar
sudo pacman -S aide

# Configurar
sudo vim /etc/aide/aide.conf

# Crear baseline
sudo aideinit

# Mover baseline
sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Verificar
sudo aide --check

# Crear script
cat > /tmp/aide_check.sh <<'EOF'
#!/bin/bash
sudo aide --check
if [ $? -ne 0 ]; then
    echo "File integrity check failed" | mail -s "AIDE Alert" admin@example.com
fi
EOF
```

### Entregable
Baseline de integridad.

---

## Ejercicio 7: OSSEC Active Response

### Objetivo
Configurar respuesta automática.

### Pasos
```bash
# Install OSSEC
sudo pacman -S ossec-hids

# Config
sudo vim /etc/ossec/active-response/definition.xml

# Agregar regla
cat > /etc/ossec/active-response/bin/ban_ip.sh <<'EOF'
#!/bin/bash
IP=$1
ALERT=$3
iptables -I INPUT -s $IP -j DROP
EOF

chmod +x /etc/ossec/active-response/bin/ban_ip.sh
```

### Entregable
IP baneada automáticamente.

---

## Ejercicio 8: SIEM Integration

### Objetivo
Enviar alertas a SIEM.

### Pasos
```bash
# Wazuh config
sudo vim /etc/wazuh/etc/ossec.conf

<active-response>
  <command>disable-account</command>
  <location>local</location>
  <rules_id>100200</rules_id>
</active-response>

# Restart
sudo systemctl restart wazuh-manager
```

### Entregable
Alertas en Wazuh.

---

## Ejercicio 9: Incident Response Playbook

### Objetivo
Crear playbook de respuesta.

### Pasos
```markdown
# Playbook: Suspicious Process
1. Identify: ps aux | grep suspicious
2. Isolate: iptables -A INPUT -s $IP -j DROP
3. Preserve: tar cvf /tmp/evidence.tar /var/log /proc/$PID
4. Eradicate: kill -9 $PID
5. Recover: restore from backup
6. Lessons Learned
```

### Entregable
Playbook documentado.

---

## Ejercicio 10: Full Detection Lab

### Objetivo
Lab completo de detección.

### Pasos
1. Configurar múltiples fuentes de logging
2. Crear reglas de correlación
3. Configurar alerting
4. Simular ataque
5. Documentar detección
6.Mejoras propuestas

### Entregable
Informe de detección.