# Plan 12 semanas — Transición a Blue Team / Defensa y Detección

Este repositorio contiene un plan práctico de 12 semanas para avanzar desde tu situación actual (programador con laboratorio propio y conocimientos básicos ofensivos) hacia un **experto teórico en Blue Team** capaz de diseñar, implementar y validar controles de seguridad en entornos reales usando tu laboratorio. El plan está pensado para realizarse en **entornos controlados y legales**.

---

## Objetivo
Convertirte en un especialista teórico-práctico de Blue Team: detección, monitorización, respuesta a incidentes, hardening y construcción de playbooks, con proyectos reproducibles en tu laboratorio.

---

## Premisas
- Infra: Ubuntu server 24/7, VMs (Linux/Windows), Raspberry Pi, Proxmark, servidores Docker, experiencia con Arch y macOS.
- Tiempo recomendado: 8–12 h/sem (puedes adaptar).
- Enfoque: herramientas open-source y proyectos reproducibles que puedas mostrar (repos, informes, dashboards).

---

## Entregables generales
- Laboratorio reproducible con máquinas instrumentadas (logs, agentes EDR simulados).
- Repos con scripts/automatizaciones para ingestión de logs y detección.
- Dashboards (Elastic/Kibana, Grafana) con casos de detección implementados.
- Playbooks de respuesta e informe de incidente simulado.
- Certificaciones objetivo sugeridas (e.g., eJPT, CompTIA Cybersecurity Analyst CySA+, o cursos de Elastic/Pluralsight).

---

## Semana 0 — Preparación del laboratorio de defensa (4–6 h)
- Instrumenta VMs: instala agentes de logging (syslog, Filebeat), y una VM Windows con logs habilitados (Event Forwarding) y snapshots.
- Reserva una VM para SIEM (Elastic Stack) y otra para pruebas (mimic attacker).
- Documenta la topología y cómo resetear snapshots.
**Deliverable:** `blue-lab-setup` README + diagrama.

---

## Semanas 1–2 — Fundamentos de logs y visibilidad (8–10 h/sem)
- Aprende formatos de logs (syslog, Windows Event IDs), dónde se originan los logs (web, app, auth, system).
- Configura Filebeat/Winlogbeat para enviar logs a Elasticsearch en tu lab.
- Crea un índice básico en Kibana y explora datos (dashboards básicos).
**Deliverable:** Pipeline Filebeat -> Elasticsearch + 3 dashboards básicos (auth, web, system).

---

## Semanas 3–4 — Detección básica y reglas (8–12 h/sem)
- Estudia TTPs comunes (recon, lateral movement, privilege escalation) a alto nivel.
- Implementa detecciones simples en Kibana (queries) y alertas (Watcher or ElastAlert).
- Crea reglas para: múltiples fallos de login, ejecución de comandos sospechosos, conexiones anómalas.
**Deliverable:** 6 reglas descriptas en YAML/JSON + pruebas en lab que generen alertas reproducibles.

---

## Semanas 5–6 — Endpoint visibility & EDR basics (8–12 h/sem)
- Instrumenta EDR-like telemetry: logs de procesos, comandos, conexión de red (osquery puede ayudarte).
- Aprende y despliega osquery en Linux/Windows en tu lab y crea packs de consultas para detección.
- Crea detecciones basadas en hashes, procesos inusuales, y persistencia común.
**Deliverable:** osquery packs + scripts para colectar artefactos post-incidente.

---

## Semanas 7–8 — Network monitoring y detección de intrusiones (8–12 h/sem)
- Monta un sensor de red (Zeek/Bro o Suricata) en tu red de laboratorio (Pi o VM con mirroring).
- Genera tráfico malicioso controlado en lab (recon, conexión a servicios) y analiza logs de Zeek/Suricata.
- Integra logs de red con Elasticsearch y añade visualizaciones específicas.
**Deliverable:** Sensor de red activo + 4 dashboards de detección (DNS anomalous, HTTP weirdness, SMB anomalies).

---

## Semanas 9–10 — Hunting y playbooks de respuesta (10–12 h/sem)
- Crea hipótesis de threat hunting (p. ej. “si un host consulta dominios DGA”).
- Ejecuta campañas de hunting: queries, pivot en logs, captura de artefactos.
- Crea playbooks de respuesta (contención, recolección de evidencia, remediación, comunicación).
**Deliverable:** 3 hunting stories documentadas + 2 playbooks en Markdown.

---

## Semanas 11–12 — Simulación de incidente y entrega final (12 h/sem)
- Ejecuta un incidente simulado en tu lab: atacante (tu VM) compromete una web, lateral movement, persistencia.
- Monitorea con tus herramientas, genera alertas, realiza hunting y aplica playbook de respuesta.
- Empaqueta todo en un informe técnico y ejecutivo (incluye dashboards, logs, timeline, recomendaciones).
**Deliverable:** Informe completo (PDF) + repos con scripts, dashboards y playbooks.

---

## Herramientas y tecnologías recomendadas
- **Logging / SIEM:** Elasticsearch + Kibana + Logstash / Filebeat / Winlogbeat; alternativas: Splunk (si tienes acceso).
- **Network monitoring:** Zeek (Bro), Suricata.
- **Endpoint telemetry:** osquery, Sysmon (Windows), Wazuh (HIDS).
- **Orquestación y alerting:** ElastAlert, Elastic Watcher, or simple cron + scripts.
- **Forensics / analysis:** Volatility (memoria), Wireshark (tráfico), sleuthkit.
- **Automatización:** Python, Bash, Ansible (deploy de agentes/packs).

---

## Recursos de aprendizaje (prácticos)
- Labs de logging en Elastic Stack, documentación osquery, proyectos Zeek/Suricata.
- TryHackMe (rutas blue team), PLURALsight o cursos específicos de Elastic/Wazuh.
- Blogs de detección y hunter reports (MSSPs, CERTs) para TTPs.

---

## Certificaciones sugeridas (orientativas)
- Intro/Concepto: CompTIA Security+ (si quieres base certificada).  
- Blue Team practico: e.g., Elastic Certified Engineer (si trabajas con Elastic), eJPT for generalist pentest basics (complementario).  
- Analyst: CompTIA CySA+ o cursos de detection engineering.  
- Avanzado: SANS FOR508/FOR500 (forensics), GCIA (network intrusion analysis) dependiendo de enfoque.

---

## Proyectos que te harán destacar
- Repos con pipelines de ingestión (beats configs) + dashboards exportables.
- Packs osquery para detección de técnicas específicas (documentados y testeados).
- Simulaciones de incidentes con timeline y mitigaciones (PDF).
- Tooling para automatizar respuesta (scripts que hacen contención básica en lab).

---

## Cómo presentarlo en LinkedIn / CV
- “Blue Team / Detection Engineer — diseño e implementación de pipelines de observabilidad y reglas de detección. Experiencia con Elasticsearch, osquery, Zeek/Suricata y playbooks de respuesta a incidentes.”
- Añade enlaces a repos con dashboards, packs osquery y el informe del incidente simulado (PDF) en tu sección de proyectos.

---

## Consejos finales
- Mantén todo reproducible (IaC / Ansible) y versionado en Git.
- Documenta pruebas: cómo generar cada alerta, snapshots, y scripts para resetear entornos.
- Practica comunicar hallazgos a técnicos y a directivos (resumen ejecutivo).

---

_Hecho por: Plan para convertir tu laboratorio y habilidades en una base sólida de Blue Team — trabaja siempre en entornos controlados._
