# Blue Team - Fase 1: Ejercicios Prácticos

## Ejercicio 1: Gestión de Usuarios

### Objetivo
Crear y configurar usuarios con políticas seguras.

### Pasos
1. Crear usuario de prueba:
   ```bash
   sudo useradd -m -s /bin/bash prueba
   sudo passwd prueba
   ```
2. Ver información: `id prueba`
3. Establecer política de contraseña:
   ```bash
   sudo chage -m 7 -M 90 -W 7 prueba
   sudo chage -l prueba
   ```
4. Agregar a grupo sudo: `sudo usermod -aG wheel prueba`
5. Configurar sudo sin contraseña: `sudo visudo` (agregar línea)

### Entregable
Capturas de cada paso y verificación final.

---

## Ejercicio 2: Permisos de Archivo

### Objetivo
Dominar permisos Unix.

### Pasos
```bash
# Crear directorio de prueba
mkdir ~/ejercicio_permisos
cd ~/ejercicio_permisos

# Crear archivos
touch archivo1 archivo2 archivo3

# Establecer permisos
chmod 644 archivo1
chmod 741 archivo2
chmod 1755 archivo3

# Verificar
ls -la

# Probar permisos
# Como usuario regular intenta escribir en archivo1
```

### Entregable
Captura de `ls -la` y explicación de cada permisos.

---

## Ejercicio 3: Permisos Especiales

### Objetivo
Practicar SUID, SGID y Sticky Bit.

### Pasos
```bash
mkdir ~/permisos_especiales
cd ~/permisos_especiales

# SUID
echo '#!/bin/bash' > test1.sh
echo 'echo "Ejecutado por $(whoami)"' >> test1.sh
chmod 4755 test1.sh
ls -la test1.sh

# SGID
mkdir testdir
chmod 2775 testdir
ls -la | grep testdir

# Sticky Bit
mkdir testtmp
chmod 1777 testtmp
ls -la | grep testtmp
```

### Entregable
Capturas y verificación del comportamiento de cada uno.

---

## Ejercicio 4: Cronjobs

### Objetivo
Crear y gestionar tareas programadas.

### Pasos
```bash
# Crear script de backup
mkdir ~/scripts
cat > ~/scripts/backup.sh << 'EOF'
#!/bin/bash
date >> ~/backup.log
echo "Backup ejecutado" >> ~/backup.log
EOF
chmod +x ~/scripts/backup.sh

# Agregar al cron
crontab -e
# Agregar línea: */1 * * * * ~/scripts/backup.sh

# Verificar
crontab -l

# Esperar 1 minuto y verificar
cat ~/backup.log
```

### Entregable
Contenido de crontab y verificación de ejecución.

---

## Ejercicio 5: Journald

### Objetivo
Dominar journalctl.

### Pasos
```bash
# Ver todos los logs
sudo journalctl

# Logs de un servicio
sudo journalctl -u sshd

# Logs de hoy
sudo journalctl --since today

# Errors y críticos
sudo journalctl -p err..crit

# Ver boot actual
sudo journalctl -b

# Ver tamaño de journal
sudo journalctl --disk-usage
```

### Entregable
Capturas relevantes de cada comando.

---

## Ejercicio 6: Configurar ufw

### Objetivo
Configurar firewall básico.

### Pasos
```bash
# Habilitar ufw (ADVERTENCIA: no hacer en remoto sin regla SSH)
sudo ufw enable

# Políticas por defecto
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Reglas básicas
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp

# Ver reglas
sudo ufw status verbose

# Probar conectividad
ping -c 3 google.com
curl -I http://google.com
```

### Entregable
Estado final de reglas ufw.

---

## Ejercicio 7: hardening SSH

### Objetivo
asegurar servicio SSH.

### Pasos
```bash
# Backup config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Editar configuración
sudo vim /etc/ssh/sshd_config

# Cambiar puerto (opcional)
# Port 2222

# Deshabilitar root
PermitRootLogin no

# Solo key authentication
PasswordAuthentication no
PubkeyAuthentication yes

# Timeout
ClientAliveInterval 300
ClientAliveCountMax 2

# Verificar sintaxis
sudo sshd -t

# Reiniciar
sudo systemctl restart sshd
```

### Entregable
Configuración final verificada con `sshd -t`.

---

## Ejercicio 8: fail2ban

### Objetivo
Instalar y configurar fail2ban.

### Pasos
```bash
# Instalar
sudo pacman -S fail2ban

# Crear configuración
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo vim /etc/fail2ban/jail.local

# Configurar jail SSH
[sshd]
enabled = true
port = ssh
filter = sshd
action = iptables[name=sshd, port=ssh, protocol=tcp]
bantime = 3600
findtime = 600
maxretry = 3

# Habilitar e iniciar
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Verificar
sudo fail2ban-client status
```

### Entregable
Estado de fail2ban y verificación de jail.

---

## Ejercicio 9: auditd

### Objetivo
Configurar auditoría básica.

### Pasos
```bash
# Instalar
sudo pacman -S audit

# Habilitar
sudo systemctl enable auditd
sudo systemctl start auditd

# Agregar reglas
sudo auditctl -w /etc/passwd -p wa -k passwd_mod
sudo auditctl -w /etc/shadow -p wa -k shadow_mod
sudo auditctl -w /usr/bin/ping -p x -k ping_use

# Ver reglas
sudo auditctl -l

# Generar evento (como root)
sudo touch /etc/passwd

# Buscar eventos
sudo ausearch -k passwd_mod
```

### Entregable
Captura de reglas ylog de auditoría.

---

## Ejercicio 10: AppArmor

### Objetivo
Practicar AppArmor en Arch.

### Pasos
```bash
# Instalar
sudo pacman -S apparmor

# Habilitar en boot
sudo vim /etc/default/grub
# Agregar: apparmor=1 security=apparmor a kernel params

# Generar grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Iniciar servicios
sudo systemctl enable apparmor
sudo systemctl start apparmor

# Ver estado
sudo aa-status

# Probar modo complain (observar)
sudo aa-complain /usr/bin/ping
```

### Entregable
Estado de AppArmor y perfil en modo complain.

---

## Ejercicio 11: Revisión de Seguridad

### Objetivo
Realizar auditoría básica del sistema.

### Pasos
```bash
# Ver usuarios
cut -d: -f1 /etc/passwd

# Ver puertos abiertos
sudo ss -tulpn

# Ver servicios activos
systemctl list-units --type=service --state=running

# Ver permisos de archivos críticos
ls -la /etc/passwd /etc/shadow /etc/sudoers

# Ver últimos logins
last
lastlog

# Ver intentos fallidos
sudo pam --last
```

### Entregable
Informe de auditoría del sistema.