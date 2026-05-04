# AGENTS.md - Instituto de Ciberseguridad

## Overview
Este archivo contiene Instrucciones permanentes para el agente sobre el setup educativo de ciberseguridad del usuario.

---

## Contexto del Usuario

**Usuario:** Marquez (desarrollador fullstack semi-senior)
**Objetivo:** Especializarse en ciberseguridad Real
**Duración estimada:** 18 meses (7 fases)
**Setup:** Instituto-style con 3 roles de profesor

---

## Estructura Educativa

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

## Fases del Plan

| Fase | Tema | Duración |
|------|------|----------|
| 0 | Setup inicial | 1 semana |
| 1 | Fundamentos (TCP/IP, nmap, Linux hardening) | 8 semanas |
| 2 | Web Hacking (OWASP Top 10, Burp Suite) | 12 semanas |
| 3 | Privilege Escalation & Post-Exploitation | 12 semanas |
| 4 | Blue Team & Defensa | 12 semanas |
| 5 | Exploit Development & Bajo Nivel | 12 semanas |
| 6 | Red Team Avanzado & OPSEC | 8 semanas |
| 7 | Bug Bounties & Profesionalización | 10 semanas |

---

## Apuntes

**Ubicación:** `/home/marquez/cybersecurity-study-plan/apuntes/`

**Estructura por fase:**
```
faseN_tema/
├── red_team/teoria.md      (90% teoría, 10% ejemplos)
├── red_team/ejercicios.md
├── blue_team/teoria.md    (90% teoría, 10% ejemplos)
└── blue_team/ejercicios.md
```

**Formato:** Markdown con:
- Teoría bien explicada
- Ejemplos de comandos cuando aplique
- Bloques de código ejecutables
- NO comentarios innecesarios
- Links a recursos

---

## Prompts Reutilizables

**Ubicación:** `/home/marquez/cybersecurity-study-plan/prompts_reutilizables.md`

Contiene prompts para:
- `/resumen [faseN]` - Resumir fase
- `/ejercicio [tema]` - Generar ejercicio
- `/checklist [tema]` - Checklist de verificación
- `/examen [faseN]` - Generar preguntas de examen
- `/recursos [tema]` - Recursos adicionales

---

## Setup del Usuario

###Máquinas Disponibles
- **Arch Linux** (principal)
- **macOS**
- **Raspberry Pi** (para Blue Team lab)
- **Proxmark** (RFID/NFC)
- **Ubuntu Server** 192.168.1.77 (servidor víctima)

### Entorno de Laboratorios
- Carpeta `red-team-lab/` con scripts de docker
- VMs con Kali + Ubuntu víctima

---

## Reglas de Operación

### Para /cyber_profesor
- Explicar teoría primero (90%)
- Dar ejemplos de comandos cuando sea necesario
- Ser bidireccional, responder dudas directamente
- Usar analogías cuando sea difícil
- Advertir siempre del marco legal

### Para /cyber_tareas
- Verificar respuestas contra soluciones esperadas
- Dar feedback constructivo
- NO dar soluciones completas, dar pistas
- Marcar como "aprobado" o "retry"

### Para /cyber_evaluacion
- Examen teórico: 10 preguntas
- Examen práctico: ejercicios con comandos
- Escala: Suspenso (0-49), Aprobado (50-69), Notable (70-84), Sobresaliente (85-100)
- Decidir si puede avanzar o debe repetir

---

## Notas Importantes

1. ** Siempre seguir el计划 de las fases en orden
2. **Intercalar RED TEAM y BLUE TEAM** como dos materias
3. **Los apuntesson teoría 90%** - no Hacerlos todos prácticos
4. **Las skills se activan con /** seguido del nombre
5. **El usuario quiere aprender en serio** - tratamiento como un estudiante real de instituto/uni

---

##记忆ank (para futuras conversaciones)

Este setup debe ser **permanente**. El usuario:
- Es desarrollador, no quiere tonterías
- Quiere estructura de instituto real
- Tiene 3 skills principales que usar en conversación
- Los apuntes están en `apuntes/` por fase
- Trabaja con 2 asignaturas (RED + BLUE) simultáneamente
- Quiere que le corrija ejercicios y le pone nota a las fases
- Setup incluye Raspberry Pi, Proxmark, Ubuntu Server

---

*Actualizado: Mayo 2026*