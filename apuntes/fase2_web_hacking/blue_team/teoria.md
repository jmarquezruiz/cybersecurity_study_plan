# Blue Team - Fase 2: Web Security Defense

## WAF - Web Application Firewall

### Tipos de WAF

| Tipo | Descripción | Ejemplos |
|------|-------------|----------|
| Network-based | Inline en red | FortiWeb, Imperva |
| Host-based | Modulo servidor | ModSecurity |
| Cloud-based | Servicio externo | Cloudflare, Akamai |

### ModSecurity

```bash
# Install
sudo pacman -S mod_security

# Config basic
sudo vim /etc/httpd/conf.d/mod_security.conf

# Reglas básicas
SecRule REQUEST_FILENAME "@beginsWith /admin" \
  "deny,status:403,msg:'Admin access blocked'"
```

### reglas OWASP

```bash
# Descargar Core Rule Set
git clone https://github.com/coreruleset/coreruleset
# Configurar
```

---

## Hardening de Aplicaciones Web

### HTTP Headers de Seguridad

```apache
# .htaccess o httpd.conf
Header always set X-Frame-Options "DENY"
Header always set X-Content-Type-Options "nosniff"
Header always set X-XSS-Protection "1; mode=block"
Header always set Referrer-Policy "strict-origin-when-cross-origin"
Header always set Content-Security-Policy "default-src 'self'"
Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
```

### nginx

```nginx
server {
    add_header X-Frame-Options "DENY";
    add_header X-Content-Type-Options "nosniff";
    add_header X-XSS-Protection "1; mode=block";
}
```

### SameSite Cookies

```python
# Flask
session.config['SESSION_COOKIE_SECURE'] = True
session.config['SESSION_COOKIE_HTTPONLY'] = True
session.config['SESSION_COOKIE_SAMESITE'] = 'Strict'
```

---

## Detección de Vulnerabilidades Web

### Escaneo con Nikto

```bash
# Escaneo básico
nikto -h http://192.168.1.77

# Con proxy
nikto -h http://192.168.1.77 -proxy http://127.0.0.1:8080

# SSL
nikto -h https://192.168.1.77 -ssl
```

### ZAP

```bash
# CLI
zap-baseline.py -t http://192.168.1.77 -r report.html

# API
curl http://localhost:8080/JSON/spider/action/scan/?url=http://192.168.1.77
```

---

## Logging Web

### Configurar Logs

```apache
# Formato personalizado
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" custom

# CustomLog
CustomLog "logs/access.log" custom
```

### Analizar Logs

```bash
# Ver requests suspicious
grep "SELECT" /var/log/apache2/access.log
grep "union" /var/log/apache2/access.log
grep -E "(script|%3C|%3E)" /var/log/apache2/access.log

# IP con más requests
awk '{print $1}' /var/log/apache2/access.log | sort | uniq -c | sort -nr | head -20
```

---

## Rate Limiting

### nginx

```nginx
http {
    limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;
    
    server {
        location /api/ {
            limit_req zone=api burst=20 nodelay;
        }
    }
}
```

### Python/Flask

```python
from flask_limiter import Limiter
limiter = Limiter(app, key_func=get_remote_address)

@app.route("/login")
@limiter.limit("5 per minute")
def login():
    #...
```

---

##防护 XSS

### Content Security Policy

```
Content-Security-Policy: 
    default-src 'self';
    script-src 'self';
    style-src 'self' 'unsafe-inline';
    img-src 'self' data:;
    connect-src 'self';
    frame-ancestors 'none';
```

### Output Encoding

```python
import html
# Siempre escapingoutput
user_input = html.escape(user_input)
```

---

## Protección SQLi

### Prepared Statements

```python
# Incorrecto
cursor.execute(f"SELECT * FROM users WHERE name = '{username}'")

# Correcto
cursor.execute("SELECT * FROM users WHERE name = %s", (username,))
```

### ORM

```python
# SQLAlchemy
user = db.query(User).filter_by(username=username).first()

# Django ORM
user = User.objects.get(username=username)
```

---

## Detección con SIEM

### Wazuh - Reglas para Web

```xml
<!-- Detectar SQLi -->
<rule id="100001" level="10">
  <dec_field>url</dec_field>
  <match>union|select|delete|drop</match>
  <description>SQL Injection attempt detected</description>
</rule>
```

### alerting

```bash
# Alertas por email
sudo vim /etc/wazuh/etc/ossec.conf

<email_alerts>
  <email_to>security@example.com</email_to>
  <rule_id>100001</rule_id>
</email_alerts>
```

---

## Resumen

| Vulnerabilidad | Defensa Principal |
|---------------|------------------|
| XSS | CSP, output encoding |
| SQLi | Prepared statements |
| CSRF | Tokens, SameSite |
| LFI | Whitelist, safe include |
| XXE | Disable external entities |
| SSRF | Whitelist de URLs |
| RCE | Sandboxing, least privilege |

---

## Recursos

- OWASP Cheat Sheets
- ModSecurity Documentation
- Mozilla Observatory
- CSP Evaluator