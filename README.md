# Instituto de Ciberseguridad - Plan de Estudio (18 meses)

---

## 🎯 Objetivo
Especialización serious en ciberseguridad real con estructura de instituto/universidad.

**Usuario:** Marquez (desarrollador fullstack semi-senior)
**Duración:** 18 meses (7 fases + setup)

---

## 📚 Estructura Educativa

### Las 3 Skills (siempre disponibles)

| Skill | Activación | Función |
|-------|-----------|---------|
| **cyber_profesor** | `/cyber_profesor` | Explicaciones dinámicas, teoría 90%, conversación bidireccional |
| **cyber_tareas** | `/cyber_tareas` | Corrección de ejercicios, feedback, aprobar/rechazar |
| **cyber_evaluacion** | `/cyber_evaluacion` | Exámenes teóricos+prácticos, puesta de nota, cierre de fase |

### Modalidad de Estudio

- **2 asignaturas simultáneas:** RED TEAM y BLUE TEAM
- **Distribución sugerida:** ~1h RED + ~1h BLUE por sesión (como ir a clase)
- **Estructura por fase:** Carpeta independiente con teoría + ejercicios para cada equipo

---

## 📋 Fases del Plan

| Fase | Tema | Duración |
|------|------|----------|
| **0** | Setup inicial | 1 semana |
| **1** | Fundamentos (TCP/IP, nmap, Linux hardening) | 8 semanas |
| **2** | Web Hacking (OWASP Top 10, Burp Suite) | 12 semanas |
| **3** | Privilege Escalation & Post-Exploitation | 12 semanas |
| **4** | Blue Team & Defensa | 12 semanas |
| **5** | Exploit Development & Bajo Nivel | 12 semanas |
| **6** | Red Team Avanzado & OPSEC | 8 semanas |
| **7** | Bug Bounties & Profesionalización | 10 semanas |

---

## 📁 Estructura de Archivos

```
/home/marquez/cybersecurity-study-plan/
├── AGENTS.md                    ← Instrucciones permanentes
├── README.md                    ← Este archivo
├── prompts_reutilizables.md    ← Prompts adicionales
├── apuntes/
│   ├── modulo0/setup_inicial.md
│   ├── fase1_fundamentos/
│   │   ├── red_team/teoria.md + ejercicios.md
│   │   └── blue_team/teoria.md + ejercicios.md
│   ├── fase2_web_hacking/
│   ├── fase3_privilege_escalation/
│   ├── fase4_blue_team_defensa/
│   ├── fase5_exploit_development/
│   ├── fase6_red_team_avanzado/
│   └── fase7_bug_bounties/
```

---

## 🛠️ Setup del Usuario

### Máquinas Disponibles

| Máquina | Función |
|---------|---------|
| **Arch Linux** | Entorno principal |
| **macOS** | Máquina de ataque |
| **Raspberry Pi** | Blue Team lab |
| **Proxmark** | Hardware hacking (RFID/NFC) |
| **Ubuntu Server** (192.168.1.77) | Servidor víctima |

### Herramientas por Fase

| Fase | Herramientas RED | Herramientas BLUE |
|------|-----------------|-------------------|
| 1 | nmap, wireshark, netcat | ufw, fail2ban, auditd |
| 2 | Burp Suite, SQLmap | ModSecurity, nikto |
| 3 | GTFOBins, winPEAS | OSSEC, auditd |
| 4 | (ataques simulados) | Wazuh, Suricata |
| 5 | pwntools, Ghidra | checksec, strings |
| 6 | Cobalt Strike, Sliver | YARA, Sigma |
| 7 | Bug bounty platforms | - |

---

## 🚀 Cómo Usar Este Plan

### Flujo de Estudio

1. **Profesor** - Leer teoría `/cyber_profesor fase 1`
2. **Práctica** - Hacer ejercicios
3. **Tareas** - Entregar `/cyber_tareas fase 1`
4. **Evaluación** - Examen `/cyber_evaluacion fase 1`
5. **Repetir** con siguiente fase

### Prompts Reutilizables

```bash
/resumen fase1        # Resumir fase
/ejercicio tcp       # Generar ejercicio
/checklist firewall  # Checklist
/examen fase2        # Preguntas examen
/recursos xss       # Recursos adicionales
```

---

## 📖 Apuntes Formato

Cada archivo de teoría sigue el formato:
- **Teoría 90%** - Explicaciones detalladas
- **Ejemplos 10%** - Comandos ejecutables
- **Referencias** - Links a recursos externos

**IMPORTANTE:**
- NO comentarios innecesarios
- Markdown con bloques de código
- Links a documentación oficial

---

## ⚠️ Marco Legal

**Regla fundamental:** Solo sistemas propios o con autorización expresa.

- Labs: Propios o HTB/VulnHub
- Bug bounties: Programas activos
- Nunca atacar sistemas externos sin permiso

---

## 📅 Distribución Semanal Sugerida (Fase 1)

| Día | Mañana | Tarde |
|-----|--------|-------|
| Lun | RED: TCP/IP | BLUE: Linux hardening |
| Mar | RED: nmap | BLUE: Usuarios/permisos |
| Mie | RED: Sniffing | BLUE: cronjobs |
| Jue | RED: netcat | BLUE: Logs |
| Vie | Práctica | Revisión |

---

## ⚙️ Skills

Las skills están en `.skills/`. Requiere configuración para funcionar con opencode.

### Instalación

```bash
# Copiar skills a ~/.agents/skills/
cp -r .skills/* ~/.agents/skills/
```

### Uso

| Skill | Activación | Función |
|-------|-----------|--------|
| **cyber_profesor** | `/cyber_profesor fase [N] [red/blue]` | Explicaciones teóricas |
| **cyber_tareas** | `/cyber_tareas fase [N] [red/blue]` | Corregir ejercicios |
| **cyber_evaluacion** | `/cyber_evaluacion fase [N]` | Examen y nota |

### Ejemplos

```bash
/cyber_profesor fase 1 red team
/cyber_profesor fase 1 blue team
/cyber_tareas fase 1 red team
/cyber_evaluacion fase 1
```

*Más info: `.skills/README.md`*

---

## 🔗 Recursos

- [PortSwigger Web Security Academy](https://portswigger.net/web-security)
- [HackTheBox](https://www.hackthebox.eu)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [GTFOBins](https://gtfobins.github.io)
- [Wazuh Documentation](https://documentation.wazuh.com)
- [pwntools](https://docs.pwntools.com)

---

*Actualizado: Mayo 2026*
