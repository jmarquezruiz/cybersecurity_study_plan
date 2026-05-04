# Skills - Instituto de Ciberseguridad

Este directorio contiene las skills personalizadas para el Instituto de Ciberseguridad.

## Estructura

```
.skills/
├── cyber_profesor/        → Skill de profesor
│   └── SKILL.md
├── cyber_tareas/        → Skill de tareas
│   └── SKILL.md
└── cyber_evaluacion/    → Skill de evaluación
    └── SKILL.md
```

## Instalación

### Método 1: Copiar a ~/.agents/skills/

```bash
# Copiar skills al directorio de opencode
cp -r .skills/* ~/.agents/skills/

# Reiniciar opencode
```

### Método 2: Registro manual

Las skills ya están registradas en `~/.agents/skills.json`.

### Verificar instalación

```bash
# En opencode, ejecutar:
/skills
```

## Uso

| Skill | Activación | Función |
|-------|-----------|--------|
| **cyber_profesor** | `/cyber_profesor fase [N] [red/blue]` | Explicaciones teóricas |
| **cyber_tareas** | `/cyber_tareas fase [N] [red/blue]` | Corregir ejercicios |
| **cyber_evaluacion** | `/cyber_evaluacion fase [N]` | Examen y nota |

## Ejemplos

```bash
# Estudiar teoría RED de Fase 1
/cyber_profesor fase 1 red team

# Estudiar teoría BLUE de Fase 1
/cyber_profesor fase 1 blue team

# Entregar ejercicios RED de Fase 1
/cyber_tareas fase 1 red team

# Hacer examen de Fase 1
/cyber_evaluacion fase 1
```

## Notas

- Estas skills son **locales** (no se instalan desde GitHub)
- Funcionan con el sistema de skills de opencode
- Requieren configuración en `~/.agents/.skill-lock.json`

---

*Para más información, ver: README.md*