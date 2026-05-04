# Prompts Reutilizables - Instituto de Ciberseguridad

---

## /resumen [faseN]
**Uso**: Resumir una fase completa con objetivos y temas clave

**Prompt completo**:
```
Resumir la Fase [N] del plan de ciberseguridad con:
- Objetivos de aprendizaje
- Temas teóricos cubiertos
- Habilidades prácticas requeridas
- Recursos recomendados
- Prerrequisitos para la fase
```

---

## /ejercicio [tema]
**Uso**: Generar un ejercicio personalizado para practicar

**Prompt completo**:
```
Crear un ejercicio práctico de [tema] para un estudiante de ciberseguridad nivel intermedio. 
Incluye:
- Enunciado del problema
- hints (ocultos)
- Solución detallada
- Comandos ejecutables
```

---

## /checklist [tema]
**Uso**: Lista de verificación de un tema específico

**Prompt completo**:
```
Generar una checklist de verificación para [tema].
Incluye:
- Items de configuración
- Comandos a verificar
- Puntos críticos de seguridad
- Commands de verificación
```

---

## /examen [faseN]
**Uso**: Preguntas tipo test para practicar teoría

**Prompt completo**:
```
Generar un examen teórico de 10 preguntas para la Fase [N] del plan de ciberseguridad.
Formato:
- 6 preguntas tipo test (4 opciones)
- 4 preguntas de desarrollo corto
- Puntuación por pregunta
- Respuestas al final
```

---

## /recursos [tema]
**Uso**: Recursos adicionales de un tema

**Prompt completo**:
```
Listar recursos adicionales para aprender [tema] en ciberseguridad:
- Cursos recomendados
- Libros
- Máquinas de práctica (HTB/VulnHub)
- Writeups relacionados
- Herramientas relacionadas
```

---

## /generar_lab [tema]
**Uso**: Generar configuración de laboratorio

**Prompt completo**:
```
Generar un docker-compose.yml para practicar [tema].
Incluye:
- Servicios necesarios
- Configuración de red
- Vulnerabilidades intencionales
- Flags de práctica
```

---

## /preguntas_examen [faseN]
**Uso**:获取考试问题

**Prompt completo**:
```
Generar 5 preguntas de examen para la Fase [N]:
- 2 preguntas conceptuales
- 1 pregunta de comandos
- 2 preguntas de troubleshooting
Con respuestas modelo.
```

---

## /analogia [concepto]
**Uso**: Explicar un concepto con analogía

**Prompt completo**:
```
Explicar [concepto] de ciberseguridad usando una analogía del mundo real.
hacerlo fácil de entender para un estudiante intermedio.
```

---

## /comparar [cosa1] vs [cosa2]
**Uso**: Comparar dos herramientas/técnicas

**Prompt completo**:
```
Comparar [cosa1] y [cosa2] en ciberseguridad:
- Ventajas
- Desventajas
- Casos de uso
- Cuándo usar cada uno
```

---

## /quick_test [tema]
**Uso**: Prueba rápida de comprensión

**Prompt completo**:
```
Generar una prueba rápida de 5 preguntas sobre [tema]:
- 3 preguntas sí/no
- 2 preguntas de comandos
Verificar comprensión básica.
```