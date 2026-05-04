# Blue Team - Fase 1: Fundamentos de Seguridad Linux

## Introducción

Como Blue Team, necesitamos dominar la hardening básico de sistemas Linux. Un sistema mal configurado es vulnerable desde el primer momento. Esta fase cubre gestión de usuarios, permisos, y configuración de seguridad básica.

---

## 1. Gestión de Usuarios

### 1.1 Tipos de Usuarios en Linux

| UID | Tipo | Uso |
|-----|------|-----|
| 0 | root | Administrador (superusuario) |
| 1-999 | sistema | Usuarios del sistema (daemons) |
| 1000+ | normales | Usuarios regulares |

### 1.2 archivos de Configuración

| Archivo | Descripción |
|---------|-------------|
| `/etc/passwd` | Info de usuarios |
| `/etc/shadow` | Contraseñas en hash |
| `/etc/group` | Info de grupos |
| `/etc/login.defs` | Políticas por defecto |

### 1.3 Comandos de Usuarios

```bash
# Crear usuario
sudo useradd -m -s /bin/bash usuario

# Establecer contraseña
sudo passwd usuario

# Modificar usuario
sudo usermod -aG grupo usuario
sudo usermod -L usuario (locking)
sudo usermod -e 2025-01-01 usuario (expiración)

# Eliminar usuario
sudo userdel -r usuario

# Ver info de usuario
id usuario
finger usuario
```

### 1.4 Políticas de Contraseñas

```bash
# Ver política actual
sudo chage -l usuario

# Establecer política
sudo chage -m 7 usuario      # Mínimo 7 días
sudo chage -M 90 usuario    # Máximo 90 días
sudo chage -W 7 usuario     # Avisar 7 días antes
sudo chage -I 30 usuario    # Bloquear tras 30 días de inactividad
sudo chage -E 2025-12-31 usuario # Expiración

# Configurar políticas globales
sudo vim /etc/login.defs
```

**Parámetros en `/etc/login.defs`:**
```
PASS_MIN_LEN 12
PASS_MIN_DAYS 1
PASS_MAX_DAYS 90
PASS_WARN_AGE 7
```

### 1.5 sudo Configuración

```bash
# Editar sudoers (seguro)
sudo visudo

# Permitir sin contraseña
usuario ALL=(ALL) NOPASSWD: ALL

# Solo comandos específicos
usuario ALL=(ALL) /usr/bin/nmap, /usr/bin/htop

# Prohibir comandos
usuario ALL=! /usr/bin/passwd, /usr/bin/newgrp
```

**Mejores prácticas sudo:**
- Usar `visudo` siempre
- Preferir grupos (`%wheel`)
- NOPASSWD solo para comandos específicos
- NO dar acceso root direto

---

## 2. Permisos de Archivo

### 2.1 Permisos Unix

| Permiso | Símbolo | Valor | Efecto en Archivo | Efecto en Directorio |
|--------|---------|------|-----------------|-------------------|
| Lectura | `r` | 4 | Ver contenido | Listar archivos |
| Escritura | `w` | 2 | Modificar | Crear/eliminar archivos |
| Ejecución | `x` | 1 | Ejecutar | Entrar al directorio |

### 2.2 Notación Octal

```
dueño  grupo  otros
rwx    rwx    rwx   = 777
rw-    rw-    r--   = 664
r-x    r--    r--   = 544
```

### 2.3 Comandos de Permisos

```bash
# Ver permisos
ls -la /home/usuario
stat archivo

# Cambiar permisos
chmod 754 archivo
chmod +x archivo
chmod u+x archivo
chmod g-w archivo

# Cambiar propietario
chown usuario:grupo archivo
chown -R usuario:grupo directorio/

# Cambiar grupo
chgrp grupo archivo
```

### 2.4 Permisos Especiales

| Permiso | Símbolo | Octal | Descripción |
|--------|---------|------|-------------|
| SUID | `s` | 4000 | Ejecuta como owner |
| SGID | `s` | 2000 | Ejecuta como grupo |
| Sticky Bit | `t` | 1000 | Solo owner puede borrar |

**Ejemplos:**
```bash
# SUID (como /usr/bin/passwd)
chmod 4755 /bin/miscript
-rwsr-xr-x root root ... /bin/miscript

# SGID (hereda grupo)
chmod 2755 /directorio
drwxr-sr-x root root ... /directorio

# Sticky Bit (como /tmp)
chmod 1777 /directorio
drwxrwxrwt root root ... /directorio
```

### 2.5 Attributes de Archivo (chattr)

```bash
# Ver atributos
lsattr archivo

# Inmutable (no se puede modificar)
sudo chattr +i archivo

# Append only (solo añadir)
sudo chattr +a archivo

# Eliminar atributos
sudo chattr -i archivo
```

---

## 3. Cronjobs

### 3.1 Tipos de Cron

| Tipo | Archivo | Uso |
|------|---------|-----|
| Sistema | `/etc/crontab` | Del sistema |
| Usuario | `crontab -e` | Por usuario |
| Hora/Hora | `/etc/cron.d/` | Por hora |
| Diario | `/etc/cron.daily/` | Diario |
| Semanal | `/etc/cron.weekly/` | Semanal |
| Mensual | `/etc/cron.monthly/` | Mensual |

### 3.2 Formato Cron

```
┌────────────── minuto (0-59)
│ ┌──────────── hora (0-23)
│ │ ┌────────── día del mes (1-31)
│ │ │ ┌──────── mes (1-12)
│ │ │ │ ┌────── día de semana (0-6, 0=Domingo)
│ │ │ │ │
* * * * * comando
```

**Ejemplos:**
```bash
# Cada hora
0 * * * * /root/backup.sh

# Cada día a las 3am
0 3 * * * /root/backup.sh

# Cada lunes a las 2am
0 2 * * 1 /root/limpieza.sh

# Cada 15 minutos
*/15 * * * * /root/check.sh
```

### 3.3 Seguridad en Cron

```bash
# Ver cronjobs del sistema
sudo ls -la /etc/cron.d/
sudo crontab -l

# Proteger archivos cron
sudo chmod 640 /etc/crontab
sudo chown root:root /etc/crontab

# Restringir acceso a crontab
sudo vim /etc/cron.deny
# Agregar usuarios forbidden
```

### 3.4 Anacron

Para sistemas que no están siempre encendidos:

```bash
# Instalar
sudo pacman -S anacron

# Configurar
sudo vim /etc/anacron/anacrontab
```

---

## 4. Journald - Logging

### 4.1 systemctl y journald

```bash
# Ver logs de un servicio
sudo journalctl -u sshd

# Logs en tiempo real
sudo journalctl -f

# Ver erroresdesde hoy
sudo journalctl --since today --priority=err

# Ver logs de boot
sudo journalctl -b

# Ver logs de un rango de tiempo
sudo journalctl --since "2025-01-01 00:00" --until "2025-01-02 00:00"
```

### 4.2 Configuración de Journald

```bash
# Archivo de config
sudo vim /etc/systemd/journald.conf

# Opciones importantes:
[Journal]
Storage=persistent
SystemMaxUse=500M
SystemMaxFilesSize=100M
RuntimeMaxUse=100M
```

### 4.3 Persistir Logs

```bash
# Crear directorio
sudo mkdir /var/log/journal

# Configurar
sudo tee /etc/systemd/journald.conf.d/99-persist.conf <<EOF
[Journal]
Storage=persistent
EOF

# Reiniciar
sudo systemctl restart systemd-journald
```

---

## 5. Firewalls en Linux

### 5.1 ufw (Uncomplicated Firewall)

```bash
# Instalar
sudo pacman -S ufw

# Habilitar
sudo ufw enable

# Reglas por defecto
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Permitir puertos
sudo ufw allow 22/tcp     # SSH
sudo ufw allow 80/tcp     # HTTP
sudo ufw allow 443/tcp    # HTTPS

# Denegar puertos
sudo ufw deny 3333/udp

# Reglas con IP específica
sudo ufw allow from 192.168.1.10 to any port 22

# Ver reglas
sudo ufw status verbose

# Eliminar regla
sudo ufw delete allow 22/tcp

# Resetear
sudo ufw reset
```

### 5.2 iptables (Legacy)

```bash
# Ver reglas actuales
sudo iptables -L -n -v

# Limpiar reglas
sudo iptables -F
sudo iptables -X
sudo iptables -Z

# Política por defecto
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

# Permisos básicos
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Bloquear IP
sudo iptables -A INPUT -s 192.168.1.100 -j DROP

#Guardar reglas
sudo iptables-save > /etc/iptables/iptables.rules
```

### 5.3 firewalld

```bash
# Instalar
sudo pacman -S firewalld

# Habilitar
sudo systemctl enable firewalld
sudo systemctl start firewalld

# Zonas
sudo firewall-cmd --list-all-zones
sudo firewall-cmd --default-zone=public

# Permitir servicio
sudo firewall-cmd --zone=public --add-service=ssh
sudo firewall-cmd --permanent --add-service=http

# Permitir puerto
sudo firewall-cmd --zone=public --add-port=8080/tcp

#reload
sudo firewall-cmd --reload
```

---

## 6. Actualizaciones y Paquetes

### 6.1 Actualizar Sistema

```bash
# Arch Linux
sudo pacman -Syu

# Ver paquetes desactualizados
sudo pacman -Qu

# Buscar actualizaciones de seguridad
sudo pacman -Fy
.news a utility for Arch security
```

### 6.2 Repositorios

```bash
# Ver mirrors
sudo vim /etc/pacman.d/mirrorlist

# Ordenar por velocidad
sudo pacman-mirrors -c Spain
```

---

## 7.-hardening de SSH

### 7.1 Configuración Segura

```bash
sudo vim /etc/ssh/sshd_config

# Configuraciones recomendadas:
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
MaxAuthTries 3
ClientAliveInterval 300
X11Forwarding no
AllowTcpForwarding no
```

### 7.2 fail2ban

```bash
# Instalar
sudo pacman -S fail2ban

# Configurar
sudo vim /etc/fail2ban/jail.local

[j sshd]
enabled = true
port = ssh
filter = sshd
action = iptables[name=SSH, port=ssh, protocol=tcp]
bantime = 3600
findtime = 600
maxretry = 3

# Iniciar
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

---

## 8. auditd - Sistema de Auditoría

### 8.1 Instalación

```bash
sudo pacman -S audit

sudo systemctl enable auditd
sudo systemctl start auditd
```

### 8.2 Reglas de Auditoría

```bash
# Ver reglas activas
sudo auditctl -l

# Agregar regla
sudo auditctl -w /etc/passwd -p wa -k passwd_mod

# Eliminar regla
sudo auditctl -W /etc/passwd

# Ver logs
sudo ausearch -k passwd_mod
```

### 8.3 Configuración

```bash
sudo vim /etc/audit/auditd.conf

# Archivo de reglas
sudo vim /etc/audit/rules.d/audit.rules

# Ejemplo de reglas:
-w /etc/passwd -p wa -k passwd_mod
-w /etc/shadow -p wa -k shadow_mod
-w /usr/bin/ping -p x -k ping_used
```

---

## 9. SELinux y AppArmor

### 9.1 AppArmor (Arch)

```bash
# Instalar
sudo pacman -S apparmor

# Habilitar
sudo systemctl enable apparmor
sudo systemctl start apparmor

# Perfiles
sudo aa-status

# enforce/complain mode
sudo aa-complain /usr/bin/firefox
sudo aa-enforce /usr/bin/firefox
```

### 9.2 SELinux

Principalmente para RHEL/Fedora, pero útil conocer:

```bash
# Estados
getenforce
sestatus

# Cambiar modo
setenforce 1 (Enforcing)
setenforce 0 (Permissive)

# Booleanos
getsebool -a
setsebool -P httpd_can_network_connect on
```

---

## Resumen

| Tema | Comandos Clave |
|------|---------------|
| Usuarios | `useradd`, `usermod`, `chmod` |
| Permisos | `chmod`, `chown`, `chattr` |
| Cron | `crontab`, `/etc/cron*` |
| Logs | `journalctl`, `auditd` |
| Firewall | `ufw`, `iptables` |
| SSH hardening | `sshd_config`, `fail2ban` |
| Auditoría | `auditd` |

---

## Referencias

- Arch Wiki: https://wiki.archlinux.org/
- CIS Benchmarks: https://www.cisecurity.org/
- Linux Hardening Guide: https://linux-audit.com/
- NSA Security Guidelines