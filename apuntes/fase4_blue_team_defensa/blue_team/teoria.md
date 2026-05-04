# Blue Team - Fase 4: Blue Team & Defensa

## 1. Logging en Linux

### 1.1 Sistemas de Logging

| Sistema | Descripción |
|---------|------------|
| syslog | Sistema tradicional |
| rsyslog | Logging avançado |
| journald | systemd journal |
| auditd | Auditoría de sistema |

### 1.2 syslog/rsyslog

```bash
# Config rsyslog
sudo vim /etc/rsyslog.conf

# Facility
*.* @@192.168.1.10:514

# Filter
:msg, contains, "failed" /var/log/failed.log
& ~
```

### 1.3 journald

```bash
# Ver logs
journalctl
journalctl -u sshd
journalctl -p err
journalctl --since "1 hour ago"
journalctl --until "1 hour ago"

# Persistir
sudo mkdir /var/log/journal
sudo systemd-tmpfiles --create --runtime /etc/tmpfiles.d/journal.conf
```

### 1.4 auditd

```bash
# Install
sudo pacman -S audit

# Rules
sudo vim /etc/audit/rules.d/audit.rules

# Ejemplos
-w /etc/passwd -p wa -k passwd_mod
-w /etc/shadow -p wa -k shadow_mod
-w /usr/bin/ping -p x -k ping_used
-w /usr/bin/sudo -p x -k sudo_exec

# Ver logs
ausearch -k passwd_mod
```

---

## 2. Windows Logging

### 2.1 Event Viewer

```cmd
# PowerShell
Get-EventLog -LogName Security -Newest 100
Get-WinEvent -FilterHashtable @{LogName='Security'; StartTime=(Get-Date).AddHours(-1)}

# XML
Get-WinEvent -FilterXml '<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event"><Data Name="EventID">4624</Data></Event>'
```

### 2.2 Windows Event IDs Importantes

| Event ID | Descripción |
|---------|------------|
| 4624 | Successful logon |
| 4625 | Failed logon |
| 4634 | Logoff |
| 4672 | Special privileges assigned |
| 4720 | User created |
| 4726 | User deleted |

### 2.3 sysmon

```powershell
# Install
 Install-Module -Name sysmon -Scope CurrentUser

# Config
sysmon -accepteula -i sysmonconfig.xml

# Logs
Get-WinEvent -LogName Microsoft-Windows-Sysmon/Operational
```

---

## 3. SIEM - Security Information and Event Management

### 3.1 Wazuh

```bash
# Install
curl -s https://packages.wazuh.com/key.gpg | sudo apt-key add -
echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list
sudo apt update
sudo apt install wazuh-manager

# Web UI
sudo apt install wazuh-dashboard
```

### 3.2 Wazuh Config

```xml
<!-- /var/ossec/etc/ossec.conf -->
<ossec_config>
  <global>
    <email_to>security@example.com</email_to>
  </global>
  
  <rules>
    <include>rules.xml</include>
  </rules>
</ossec_config>
```

### 3.3 Wazuh Rules

```xml
<rule id="100001" level="10">
  <dec_field>program_name</dec_field>
  <match>sshd</match>
  <description>SSH connection</description>
</rule>

<rule id="100002" level="12">
  <dec_field>rootwatch</dec_field>
  <match>failed</match>
  <description>Authentication failure</description>
</rule>
```

### 3.4 ELK Stack

```bash
# Install Elasticsearch
docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch

# Logstash
docker run -d -p 5044:5044 -v /etc/logstash/pipeline:/usr/share/logstash/pipeline logstash

# Kibana
docker run -d -p 5601:5601 kibana
```

---

## 4. IDS/IPS

### 4.1 Snort

```bash
# Install
sudo pacman -S snort

# Config
sudo vim /etc/snort/snort.conf
# HOME_NET 192.168.1.0/24

# Rules
# alert tcp any any -> $HOME_NET 80 (msg:"HTTP"; sid:1000001;)

# Run
sudo snort -i eth0 -c /etc/snort/snort.conf
```

### 4.2 Suricata

```bash
# Install
sudo pacman -S suricata

# Config
sudo vim /etc/suricata/suricata.yaml
# vars:
#   address-groups:
#     HOME_NET: "[192.168.1.0/24]"

# Rules
# alert http $HOME_NET any -> $EXTERNAL_NET any (msg:"SQL Injection Attempt"; flow:to_server; content:"' OR '1'='1"; classtype:web-application-attack; sid:1000001; rev:1;)

# Run
sudo suricata -c /etc/suricata/suricata.yaml -i eth0
```

### 4.3 Zeek (Bro)

```bash
# Install
sudo pacman -S zeek

# Run
sudo zeek -C -i eth0

# Logs
ls /var/log/zeek/
```

---

## 5. Hardening de Servidores

### 5.1 ufw

```bash
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

### 5.2 fail2ban

```bash
sudo pacman -S fail2ban

# Config
sudo vim /etc/fail2ban/jail.local

[sshd]
enabled = true
port = ssh
filter = sshd
action = iptables[name=SSH, port=ssh, protocol=tcp]
bantime = 3600
findtime = 600
maxretry = 3

sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

### 5.3 AppArmor

```bash
sudo pacman -S apparmor
sudo systemctl enable apparmor
sudo systemctl start apparmor

sudo aa-status
sudo aa-complain /usr/bin/programa
sudo aa-enforce /usr/bin/programa
```

### 5.4 SELinux

```bash
# RHEL/CentOS
getenforce
setenforce 1

# Booleanos
getsebool -a
setsebool -P httpd_can_network_connect on

# Context
semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
restorecon -Rv /web
```

---

## 6. Resumen hard

| Componente | Función | Herramientas |
|-----------|---------|--------------|
| Logging | Recolección | rsyslog, journald, auditd |
| SIEM | Correlación | Wazuh, ELK |
| IDS/IPS | Detección | Snort, Suricata |
| Firewall | Control | ufw, iptables |
| Hardening | Refuerzo | fail2ban, AppArmor |

---

## Recursos

- Wazuh Documentation
- Suricata Rules
- CIS Benchmarks