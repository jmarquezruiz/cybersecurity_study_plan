# Módulo 0: Setup Inicial del Entorno

## Objetivos
- Instalar herramientas básicas de ciberseguridad
- Configurar laboratorio de práctica
- Verificar conectividad entre máquinas
- Preparar entorno para Fase 1

---

## Herramientas por Categoría

### Escaneo y Enumeración
| Herramienta | Descripción | Install |
|-------------|-------------|---------|
| nmap | Escáner de puertos | `sudo pacman -S nmap` |
| netcat | Netcat para conexiones | `sudo pacman -S netcat` |
| masscan | Escáner rápido | `sudo pacman -S masscan` |

### Web
| Herramienta | Descripción | Install |
|-------------|-------------|---------|
| curl | HTTP client | `sudo pacman -S curl` |
| gobuster | Enum directorios | `yay gobuster` o `sudo pacman -S gobuster` |
| dirb | Enum directorios | `yay dirb` |

### Fuerza Bruta
| Herramienta | Descripción | Install |
|-------------|-------------|---------|
| hydra | Fuerza bruta | `yay hydra` |

### Sniffing
| Herramienta | Descripción | Install |
|-------------|-------------|---------|
| wireshark | Analizador de red | `sudo pacman -S wireshark` |
| tcpdump | Sniffer CLI | `sudo pacman -S tcpdump` |

---

## Setup de Laboratorio

### Máquina Atacante (Kali/Arch)
```bash
# Instalar herramientas básicas
sudo pacman -Syu
sudo pacman -S nmap wireshark tcpdump curl netcat

# Gobuster (AUR)
yay -S gobuster

# Hydra (AUR)
yay -S hydra
```

### Máquina Víctima (Ubuntu Server)
```bash
# Apache
sudo apt install apache2

# MySQL
sudo apt install mysql-server

# PHP (para DVWA)
sudo apt install php libapache2-mod-php php-mysql
```

### Configuración de Red
```bash
# Verificar IP
ip a
ip route show

# Ping de prueba
ping -c 4 192.168.1.77

# Escaneo inicial
nmap -sn 192.168.1.0/24
```

---

## Verificación de Conectividad

### Checklist
- [ ] ping a Ubuntu Server responde
- [ ] nmap muestra puertos abiertos
- [ ] Web server accesible (curl http://192.168.1.77)
- [ ] SSH funciona (ssh user@192.168.1.77)

### Comandos de Test
```bash
# Ping
ping -c 3 192.168.1.77

# Puerto 80
curl -I http://192.168.1.77

# Puerto 22
nc -zv 192.168.1.77 22

# Escaneo completo
nmap -p- 192.168.1.77
```

---

## Linux Hardening Básico (Tu Arch)

### Crear usuario no-root
```bash
# Crear usuario
sudo useradd -m -G wheel usuario

# Establecer contraseña
sudo passwd usuario

# Verificar grupos
groups usuario
```

### Configurar sudo
```bash
# Editar sudoers
sudo visudo

# Agregar linea (usuario puede usar sudo sin password)
usuario ALL=(ALL) NOPASSWD: ALL
```

### Firewall (ufw/firewalld)
```bash
# Instalar ufw
sudo pacman -S ufw

# Habilitar
sudo ufw enable

# Reglas básicas
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
```

---

## Siguiente
Con el entorno listo, proceeder a **Fase 1: Fundamentos**