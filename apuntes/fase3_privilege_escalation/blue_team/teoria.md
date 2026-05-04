# Blue Team - Fase 3: Detección de Escalada y Post-Exploitation

## 1. Detección de Privilege Escalation

### 1.1 Monitoreo de Procesos

```bash
# Procesos inusuales
ps aux | grep -E "(nc|netcat|ncat|metasploit|cobalt)"

# Procesos con root
ps -ef | grep "^root"

# Comparar con baseline
diff <(ps aux) <(cat baseline.txt)
```

### 1.2 Detección de SUID

```bash
# Comparar SUID actual con baseline
diff <(find / -perm -4000 2>/dev/null | sort) <(cat baseline_suid.txt)

# Alertas
auditctl -w /usr/bin/su -p x -k su_exec
```

### 1.3 Monitoreo de Cron

```bash
# Ver nuevos cronjobs
cat /etc/crontab
ls -la /etc/cron.d/

# Logs de cron
grep -i cron /var/log/syslog
journalctl | grep -i cron
```

### 1.4 Capabilities Sospechosas

```bash
# Capabilities anómalas
getcap -r / 2>/dev/null
# Alertar si python/perl tiene caps inusuales
```

---

## 2. Detección de Persistencia

### 2.1 Registry Windows

```cmd
# Run keys
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"

# Services
reg query "HKLM\System\CurrentControlSet\Services"
```

### 2.2 Cronjobs Linux

```bash
# Nuevas tareas
crontab -l
cat /etc/cron.daily/

# systemd services
systemctl list-units --type=service --all
```

### 2.3 .bashrc Modifications

```bash
# Detectar cambios
diff ~/.bashrc ~/.bashrc.bak

# Monitoring
auditctl -w ~/.bashrc -p wa -k bashrc_mod
```

---

## 3. Detección de Pivoting

### 3.1 Conexiones Sospechosas

```bash
# Conexiones establecidas
netstat -tulpn | grep ESTABLISHED

# Conexiones a IPs internas
ss -tnp | grep ESTABLISHED

# Puertos inusuales
ss -tulpn | grep -v -E "(80|443|22|53)"
```

### 3.2 Firewall Rules

```bash
# Nuevas reglas
sudo iptables -L -n -v
sudo iptables-save > /tmp/iptables_current

# Comparar
diff /tmp/iptables_baseline /tmp/iptables_current
```

---

## 4. Detección de Credenciales

### 4.1 Linux

```bash
# shadow cambios
stat /etc/shadow

# passwd cambios
stat /etc/passwd

# sudoers
cat /etc/sudoers

# SSH keys
ls -la ~/.ssh/
```

### 4.2 Windows

```cmd
# SAM changes
reg query "HKLM\SAM"

# New services
sc query

# New users
net user
```

---

## 5. Incident Response

### 5.1 Recolección de Evidencia

```bash
# memory dump
linpm -d /dev/mem -o memory.raw

# disk image
dd if=/dev/sda of=disk.image

# Logs importantes
tar cvf logs.tar /var/log/*.log /etc /root/.bash_history
```

### 5.2 Análisis de Timeline

```bash
# Ver eventos
sudo logwatch --detail high

# Journal
sudo journalctl --since "1 hour ago"

# auth.log
tail -f /var/log/auth.log
```

### 5.3 Containment

```bash
# Aislamiento de máquina
sudo iptables -A INPUT -j DROP
sudo iptables -A OUTPUT -j DROP

# Bloquear usuario
sudo userdel -r comprometido
sudo passwd -l usuario
```

---

## 6. SIEM Integration

### 6.1 Wazuh Rules

```xml
<rule id="100200" level="10">
  <dec_field>process</dec_field>
  <match>^/bin/bash</match>
  <description>Shell execution detected</description>
</rule>

<rule id="100201" level="12">
  <dec_field>command</dec_field>
  <match>wget|curl.*http</match>
  <description>Download primitive detected</description>
</rule>
```

### 6.2 Alerting

```bash
# Configurar alertas
sudo vim /etc/wazuh/etc/ossec.conf

<email_alerts>
  <email_to>security@example.com</email_to>
  <rule_id>100200</rule_id>
</email_alerts>
```

---

## 7. Herramientas de Detección

### 7.1 OSSEC

```bash
# Install
sudo pacman -S ossec-hids

# Config active response
sudo vim /etc/ossec/agent/shared/active-response/bin/blacklist.sh

# Start
sudo systemctl enable ossec-hids
sudo systemctl start ossec-hids
```

### 7.2 AIDE

```bash
# Install
sudo pacman -S aide

# Init database
sudo aideinit

# Check
sudo aide -c /etc/aide/aide.conf --check
```

---

## Resumen

| Técnica de Ataque | Indicator de Detección |
|-----------------|----------------------|
| SUID nuevo | `find / -perm -4000` |
| Cronjob modificado | `/etc/crontab` |
| Registry Run | `reg query ... Run` |
| Conexión suspeita | `netstat` |
| Nuevo usuario | `useradd` |

---

## Recursos

- MITRE ATT&CK
- Detection Rules
- SIEM documentation