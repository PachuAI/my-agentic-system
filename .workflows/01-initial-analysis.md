# Workflow: Análisis Inicial del PRD

## Trigger
- Cuando se clona el repositorio semilla
- Cuando se agrega un PRD.md al proyecto
- Cuando el hook `session-start-context.sh` detecta un PRD

## Prerequisitos
- [ ] Repositorio semilla clonado
- [ ] PRD.md (o similar) presente en la raíz
- [ ] Claude Code iniciado con acceso a MCPs

## Pasos del Workflow

### 1. Verificación de Prerequisitos
```bash
# El hook session-start-context.sh automáticamente verifica:
- [ ] Existe PRD.md, prd.md o requirements.md
- [ ] Estructura semilla está completa
- [ ] Claude Code tiene acceso a Context-7
- [ ] Carpeta .output existe y está vacía
```

### 2. Lectura y Comprensión Inicial
- **Leer completamente** el archivo PRD
- **Leer** INIT-INSTRUCTIONS.md para entender el proceso
- **Identificar** tipo de proyecto y dominio
- **Extraer** requerimientos principales a alto nivel

### 3. Análisis Estructurado
**Ejecutar el comando:** `/analyze-prd`

**Este comando debe:**
- Usar el template `.analysis/prd-analysis-template.md`
- Extraer todos los requerimientos funcionales y no funcionales
- Identificar componentes principales (Frontend, Backend, Data)
- Priorizar features (MVP vs Nice-to-have)
- Estimar complejidad inicial por componente
- Identificar integraciones externas necesarias
- Listar preguntas críticas para el cliente
- Documentar asunciones hechas

**Output esperado:** `.output/prd-analysis.md`

### 4. Research de Contexto
**Usar Context-7 para investigar:**
- Dominios técnicos mencionados en el PRD
- Mejores prácticas para el tipo de aplicación
- Frameworks populares para casos similares
- Patrones arquitectónicos recomendados

**Usar WebSearch para:**
- Tendencias actuales en el dominio
- Casos de éxito similares
- Benchmarks de performance
- Consideraciones de compliance/regulatorias

### 5. Validación del Análisis
- **Revisar** que todos los requerimientos del PRD estén capturados
- **Verificar** que las prioridades tengan sentido
- **Confirmar** que las estimaciones de complejidad sean razonables
- **Validar** que las asunciones estén claramente documentadas

### 6. Identificación de Gaps
- **Detectar** ambigüedades en el PRD
- **Listar** información faltante crítica
- **Priorizar** preguntas por importancia
- **Documentar** áreas que necesitan clarificación

## Outputs del Workflow

Al finalizar este workflow, deben existir:

### Archivos Generados
- `.output/prd-analysis.md` - Análisis completo y estructurado
- `.output/initial-research.md` - Research de contexto
- `.output/questions-for-client.md` - Preguntas prioritarias
- `.output/assumptions-log.md` - Asunciones documentadas

### Información Capturada
- **Requerimientos funcionales** completamente mapeados
- **Requerimientos no funcionales** identificados
- **Componentes principales** y sus relaciones
- **Complejidad estimada** por área
- **Integraciones externas** necesarias
- **Riesgos iniciales** identificados
- **Preguntas críticas** para validación

## Criterios de Éxito

### Must Have
- [ ] Todos los requerimientos del PRD están documentados
- [ ] Complejidad estimada por componente principal
- [ ] Integraciones externas identificadas
- [ ] MVP claramente definido
- [ ] Preguntas críticas formuladas

### Should Have
- [ ] Research de contexto completado
- [ ] Asunciones documentadas y justificadas
- [ ] Riesgos iniciales identificados
- [ ] Patrones arquitectónicos investigados

### Nice to Have
- [ ] Benchmarks de performance investigados
- [ ] Casos de éxito similares analizados
- [ ] Consideraciones de compliance documentadas

## Posibles Problemas y Soluciones

### Problema: PRD muy vago o incompleto
**Solución:**
- Documentar todas las ambigüedades
- Crear lista priorizada de preguntas
- Hacer asunciones razonables y documentarlas
- Proceder con análisis basado en interpretación más probable

### Problema: PRD demasiado técnico o complejo
**Solución:**
- Desglosar en componentes más pequeños
- Usar Context-7 para research profundo
- Crear diagramas de flujo para clarificar
- Priorizar features para manejo de complejidad

### Problema: Requerimientos contradictorios
**Solución:**
- Documentar las contradicciones específicamente
- Proponer resoluciones con pros/cons
- Marcar como pregunta de alta prioridad
- Crear escenarios alternativos

## Quality Gates

Antes de proceder al siguiente workflow, verificar:

### Completitud
- [ ] Análisis de PRD 100% completo
- [ ] Todos los outputs requeridos generados
- [ ] Research de contexto realizado
- [ ] Preguntas documentadas

### Calidad
- [ ] Análisis es comprensible y detallado
- [ ] Estimaciones de complejidad son razonables
- [ ] Asunciones están justificadas
- [ ] Preguntas son específicas y accionables

### Preparación para Siguiente Fase
- [ ] Información suficiente para recomendar stack
- [ ] Componentes claros para diseño arquitectónico
- [ ] Base sólida para plan de acción

## Siguiente Paso
→ **Proceder a** `02-technical-planning.md`

**Comando siguiente:** `/tech-stack-recommendation`

---

*Workflow creado para optimizar el proceso de análisis inicial*
*Revisión: v1.0*