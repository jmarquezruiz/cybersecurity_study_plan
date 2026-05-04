# Red Team - Fase 1: Ejercicios Prácticos

## Ejercicio 1: TCP/IP Handshake

### Objetivo
Observar un three-way handshake TCP en acción.

### Pasos
1. Abre dos terminales
2. En Terminal 1: `sudo tcpdump -i lo tcp -w handshake.pcap`
3. En Terminal 2: `nc -v localhost 9999` (previamente configura un servidor con `nc -lp 9999`)
4. Detén tcpdump y analiza el archivo

### Entregable
Captura de pantalla del three-way handshake visto en Wireshark.

---

## Ejercicio 2: Tabla ARP

### Objetivo
Manipular la tabla ARP.

### Pasos
1. Ver tu tabla ARP: `arp -a`
2. Agregar entrada estática: `arp -s 192.168.1.99 aa:bb:cc:dd:ee:ff`
3. Verificar: `arp -a | grep 192.168.1.99`
4. Eliminar: `arp -d 192.168.1.99`

### Entregable
Captura de pantalla de cada paso.

---

## Ejercicio 3: Consultas DNS

### Objetivo
Realizar diferentes tipos de consultas DNS.

### Pasos
```bash
# Consulta A
dig A google.es +short

# Consulta MX
dig MX google.es +short

# Consulta NS
dig NS google.es +short

# Consulta TXT (SPF)
dig TXT google.es +short

# Whois
whois google.es
```

### Entregable
Captura con los resultados de cada query.

---

## Ejercicio 4: Captura de Tráfico con tcpdump

### Objetivo
Capturar y analizar tráfico de red.

### Pasos
1. Capturar solo tráfico HTTP:
   ```bash
   sudo tcpdump -i eth0 'tcp port 80' -w http.pcap
   ```
2. Generar tráfico (en otra terminal): `curl http://example.com`
3. Analizar la captura:
   ```bash
   tcpdump -r http.pcap -v
   ```

### Entregable
Archivo .pcap y análisis de las cabeceras TCP.

---

## Ejercicio 5: Escaneo con nmap

### Objetivo
Dominar los diferentes tipos de escaneo.

### Pasos
```bash
# Escaneo básico
nmap 192.168.1.77

# Detección de SO
sudo nmap -O 192.168.1.77

# Versiones de servicios
sudo nmap -sV 192.168.1.77

# Scripts por defecto
sudo nmap -sC 192.168.1.77

# Escaneo completo
sudo nmap -A 192.168.1.77

# Escanear subred completa
nmap -sn 192.168.1.0/24
```

### Entregable
Captura de cada escaneo con interpretación.

---

## Ejercicio 6: netcat - Conexiones

### Objetivo
Practicar conexiones con netcat.

### Pasos
1. **Servidor simple:**
   ```bash
   nc -lp 9000
   ```
2. **Cliente simple:**
   ```bash
   nc localhost 9000
   ```
3. **Transferir archivo:**
   ```bash
   # Servidor
   nc -lp 9000 < prueba.txt
   # Cliente
   nc localhost 9000 > recibido.txt
   ```

### Entregable
Capturas de las conexiones.

---

## Ejercicio 7: Enumeración de Red

### Objetivo
Descubrir dispositivos en la red local.

### Pasos
```bash
# nmap ping sweep
nmap -sn 192.168.1.0/24

# Detectar tu IP y gateway
ip a
ip route

# Ver vecinos ARP
ip neigh show
```

### Entregable
Lista de dispositivos encontrados.

---

## Ejercicio 8: Fuerza Bruta con Hydra

### Objetivo
Entender cómo funciona la fuerza bruta (en lab controlado).

### Pasos
1. Crear wordlist pequeña:
   ```
   password
   admin
   test
   ```
2. Intentar SSH (con cuenta conocida):
   ```bash
   hydra -l root -P wordlist.txt 192.168.1.77 ssh -t 4
   ```
3. Analizar el output

### ⚠️ ADVERTENCIA
Solo en sistemas que controlas. No использовать en sistemas externos.

### Entregable
Screenshot del resultado.

---

## Ejercicio 9: Análisis con Wireshark

### Objetivo
Analizar captura de red en Wireshark.

### Pasos
1. Abrir Wireshark
2. Importar archivo de ejercicio 4
3. Aplicar filtros:
   - `tcp.stream eq 0`
   - `ip.addr == x.x.x.x`
   - `http.request`
4. Seguir stream TCP
5. Exportar objetos HTTP

### Entregable
Capturas de pantalla del análisis.

---

## Ejercicio 10: Resumen de Puertos Abiertos

### Objetivo
Documentar los puertos abiertos de tu servidor.

### Pasos
```bash
# Escaneo completo
sudo nmap -p- -sV -sC -O 192.168.1.77

# Puertos específicos
nmap -p 21,22,25,80,443,3306,8080 192.168.1.77

# Formato grepable
nmap -p- -oG resultados.txt 192.168.1.77
```

### Entregable
Documento con:
- Puertos abiertos
- Servicios detectados
- Versiones
- Recomendaciones