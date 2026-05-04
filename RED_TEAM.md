# Plan 12 semanas — Transición a Red Team / Cybersecurity Engineer (Ofensiva)

Este repositorio contiene un plan práctico de 12 semanas (con entregables) para transitar desde tu rol actual de desarrollador Laravel hacia Red Team / Cybersecurity Engineer. El plan está pensado para realizarse **en entornos controlados y legales** (labs, TryHackMe, HTB, máquinas propias). Incluye tareas semanales, entregables y recursos recomendados.

---

## Objetivo
Convertirte en Red Team / Offensive-oriented security engineer junior con portfolio y una certificación práctica (eJPT → OSCP/CRTP según especialización).

---

## Premisas
- Tienes infra propia: Ubuntu server 24/7, VMs, Raspberry Pi, Proxmark, macOS y Arch Linux.
- Tiempo recomendado: ~10–12 h/sem (puedes adaptarlo).
- Todo debe realizarse en entornos controlados y con permiso. No ataques a terceros sin autorización.

---

## Entregables generales
- Repositorios con scripts y herramientas (documentados).
- Writeups públicos de labs (metodología + mitigación).
- Un engagement simulado completo en tu lab con informe técnico y ejecutivo.
- Certificaciones objetivo: eJPT → OSCP / CRTP (según interés).

---

## Semana 0 — Preparación del laboratorio (4–6 h)
- Monta VMs: Kali, Windows Server (AD), máquinas vulnerables (Metasploitable, DVWA, Juice Shop).
- Configura snapshots y backups.
- Raspberry Pi como target IoT aislado.
**Deliverable:** `lab-setup` README + diagrama.

---

## Semanas 1–2 — Recon & Web fundamentals (OWASP) (10–12 h/sem)
- PortSwigger Web Academy (OWASP Top 10).
- TryHackMe: “Web Fundamentals” y “Complete Beginner”.
- Practica Burp interceptando Juice Shop.
**Deliverable:** 2 writeups + script básico para enumerar subdominios.

---

## Semanas 3–4 — Recon avanzado & scripting (10–12 h/sem)
- Herramientas: `nmap`, `amass`, `gobuster`, `ffuf`.
- Desarrolla script Python: subdomain enum -> nmap -> export JSON.
- Practica HTB/THM máquinas.
**Deliverable:** `recon-tool` en GitHub + 2 writeups.

---

## Semanas 5–6 — Escalada y post-explotación (AD basics) (10–12 h/sem)
- Monta Active Directory en lab.
- Estudia Kerberos, NTLM, GPO, privilegios.
- Simula cadenas de escalada en entornos controlados.
**Deliverable:** Writeup de una cadena de escalada (metodología + mitigación).

---

## Semanas 7–8 — Wireless & hardware basics (proxmark / RPi) (8–10 h/sem)
- Pruebas con Proxmark (Mifare classic) en entorno controlado.
- Raspberry Pi como honeypot/target; captura y análisis de logs.
**Deliverable:** Blogpost técnico sobre Mifare y mitigaciones + documentación Pi.

---

## Semanas 9–10 — Automating & tool development (10–12 h/sem)
- Crea herramienta que automatice recon -> export -> plantilla de informe Markdown.
- Tests mínimos y README pulido.
**Deliverable:** `recon-to-report` repo + plantilla de informe.

---

## Semanas 11–12 — Simulación de engagement + portfolio (12 h/sem)
- Ejecuta ejercicio completo en lab: planificación, recon, explotación controlada, post-exploit y cierre.
- Crea informe técnico y ejecutivo, captures de evidencia y logs.
**Deliverable:** Engagement completo empaquetado en repo y PDF.

---

## Recursos recomendados
- TryHackMe, Hack The Box, PortSwigger Web Academy, VulnHub, PentesterLab.
- Herramientas: Burp Suite, Nmap, Metasploit (uso conceptual), Wireshark, Proxmark, Amass, ffuf.
- Lectura: blogs Mandiant, CrowdStrike, recursos sobre TTPs y detección.

---

## Certificaciones sugeridas
- Entrada: eJPT, CompTIA Security+.
- Intermedio/Ofensiva: OSCP.
- Especializado AD: CRTP.
- Avanzado: OSCE, SANS (según objetivo).

---

## Cómo presentar en LinkedIn / CV
- Frases ejemplo corto:
  - “Red Team / Offensive Security Engineer — desarrollo de tooling de reconocimiento y creación de playbooks en entornos controlados. Experiencia con Burp, Nmap, Metasploit, scripting en Python y Active Directory en laboratorio.”
- Proyectos: enlaces a repos, writeups (metodología, mitigación), badges de TryHackMe/HTB.

---

## Consejos legales y de ética
- Solo en entornos con permiso.
- Documenta siempre pruebas y backups.
- No publiques PoCs peligrosos contra terceros.

---

## Siguientes pasos
- Publica repos con tus scripts y writeups.
- Planifica certificaciones y fechas objetivo (e.g., eJPT en 3–6 meses).
- Si quieres, puedo convertir esto en un calendario diario adaptado a **tu disponibilidad exacta** y una plantilla de README y writeup listos para usar.

---

_Hecho por: Plan generado para tu transición a Red Team — usa en tu lab y en entornos con permiso._
