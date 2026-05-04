# Blue Team - Fase 4: Defense Ejercicios

## Ejercicio 1: Setup rsyslog

### Objetivo
Configurar logging centralizado.

### Pasos
```bash
# Install rsyslog
sudo pacman -S rsyslog

# Config servidor
sudo vim /etc/rsyslog.conf
# $ModLoad imtcp
# $InputTCPServerRun 514

# Restart
sudo systemctl enable rsyslog
sudo systemctl start rsyslog
```

### Entregable
Servidor escuchando en 514.

---

## Ejercicio 2: auditd Setup

### Objetivo
Configurar auditoría.

### Pasos
```bash
# Install
sudo pacman -S audit

# Enable
sudo systemctl enable auditd
sudo systemctl start auditd

# Crear reglas
sudo vim /etc/audit/rules.d/security.rules

-w /etc/passwd -p wa -k passwd_mod
-w /etc/shadow -p wa -k shadow_mod
-w /usr/bin/ping -p x -k ping_use
-w /usr/bin/sudo -p x -k sudo_use

# Ver logs
sudo ausearch -k passwd_mod
```

### Entregable
Auditoría funcionando.

---

## Ejercicio 3: Wazuh Installation

### Objetivo
Instalar Wazuh.

### Pasos
```bash
# Install manager
curl -s https://packages.wazuh.com/key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/wazuh-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh-archive-keyring.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list
sudo apt update
sudo apt install wazuh-manager

# Dashboard
sudo apt install wazuh-dashboard
```

### Entregable
Wazuh funcionando.

---

## Ejercicio 4: Suricata Setup

### Objetivo
Instalar y configurar Suricata.

### Pasos
```bash
# Install
sudo pacman -S suricata

# Config
sudo vim /etc/suricata/suricata.yaml
# HOME_NET: [192.168.1.0/24]

# Reglas personalizadas
sudo vim /etc/suricata/rules/local.rules
alert tcp $HOME_NET any -> $EXTERNAL_NET any (msg:"Outbound TCP"; sid:1000001; rev:1;)

# Run
sudo suricata -c /etc/suricata/suricata.yaml -i eth0
```

### Entregable
Suricata detectando tráfico.

---

## Ejercicio 5: fail2ban Setup

### Objetivo
Configurar fail2ban.

### Pasos
```bash
sudo pacman -S fail2ban

# Config
sudo vim /etc/fail2ban/jail.local

[sshd]
enabled = true
port = ssh
filter = sshd
bantime = 3600
findtime = 600
maxretry = 3

# Enable
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo fail2ban-client status
```

### Entregable
fail2ban baneando IPs.

---

## Ejercicio 6: Hardening Apache

### Objetivo
Endurecer Apache.

### Pasos
```bash
# Install
sudo pacman -S apache

# Headers
sudo vim /etc/httpd/conf/extra/security.conf
Header always set X-Frame-Options "DENY"
Header always set X-Content-Type-Options "nosniff"
Header always set X-XSS-Protection "1; mode=block"

# Disable version
ServerTokens Prod
ServerSignature Off
TraceEnable Off
```

### Entregable
Apache endurecido.

---

## Ejercicio 7: AppArmor Profiles

### Objetivo
Crear perfiles AppArmor.

### Pasos
```bash
# Install
sudo pacman -S apparmor

# Enable
sudo systemctl enable apparmor

# Profile
sudo vim /etc/apparmor.d/usr.bin.programa
/usr/bin/programa {
  # allow
}

# Enforce
sudo aa-enforce /usr/bin/programa

# Status
sudo aa-status
```

### Entregable
Perfil activo.

---

## Ejercicio 8: Snort Rules

### Objetivo
Crear reglas Snort.

### Pasos
```bash
sudo pacman -S snort

# Config
sudo vim /etc/snort/local.rules
alert tcp $HOME_NET any -> $EXTERNAL_NET 80 (msg:"HTTP Traffic"; sid:1000001;)
alert icmp $HOME_NET any -> $EXTERNAL_NET any (msg:"ICMP"; sid:1000002;)

# Test
sudo snort -c /etc/snort/snort.conf -T
```

### Entregable
Snort ejecutándose.

---

## Ejercicio 9: SIEM Dashboard

### Objetivo
Crear dashboard SIEM.

### Pasos
1. Acceder a Kibana/Wazuh
2. Crear visualización de eventos
3. Crear dashboard de seguridad
4. Configurar alertas
5. Compartir

### Entregable
Dashboard funcional.

---

## Ejercicio 10: Incident Response

### Objetivo
Simular IR.

### Pasos
1. Detect alert: "Possible intrusion"
2. Triage: Investigate log
3. Contain: Isolate system
4. Eradicate: Remove threat
5. Recover: Restore
6. Document

### Entregable
Playbook IR.