# 🌱 Agentic Seed - Sistema de Análisis y Planificación Pre-Desarrollo

Sistema semilla para inicializar proyectos con Agentic Coding, diseñado para analizar PRDs y crear planes de acción sólidos ANTES de escribir código.

## 🎯 Objetivo

Esta carpeta semilla NO contiene documentación de frameworks ni código específico. En su lugar, proporciona:

- **Estructura** para análisis sistemático de requerimientos
- **Comandos** para planificación automatizada
- **Templates** para documentación consistente
- **Workflows** para proceso ordenado
- **Hooks** para automatización inteligente

## 🚀 Cómo Usar

### 1. Preparación
```bash
# Clonar esta plantilla
git clone [url-de-tu-repo-semilla] my-new-project
cd my-new-project

# Agregar tu PRD
cp /path/to/your/PRD.md ./PRD.md

# Iniciar Claude Code
claude
```

### 2. Análisis Automático
Claude Code detectará el PRD y la estructura semilla. Seguirá automáticamente el proceso de análisis antes de codear.

### 3. Comandos de Análisis
```bash
/analyze-prd              # Extrae y estructura requerimientos
/tech-stack-recommendation # Recomienda tecnologías basado en PRD
/architecture-design      # Diseña arquitectura sin codear
/create-action-plan      # Genera plan de desarrollo detallado
/identify-risks          # Identifica riesgos técnicos
/estimate-complexity     # Estima esfuerzo y tiempo
```

### 4. Outputs
Todos los análisis se guardan en `.output/`:
- `prd-analysis.md` - Requerimientos estructurados
- `tech-stack-decision.md` - Stack recomendado con justificación  
- `architecture-design.md` - Diseño de arquitectura
- `action-plan.md` - Plan de acción ejecutable
- `risk-assessment.md` - Riesgos y mitigaciones

## 📋 Flujo de Trabajo

```mermaid
graph TD
    A[Clone Seed + Add PRD] --> B[Claude Analyzes Structure]
    B --> C[/analyze-prd]
    C --> D[/tech-stack-recommendation]
    D --> E[/architecture-design]
    E --> F[/create-action-plan]
    F --> G{Plan Approved?}
    G -->|Yes| H[/setup-development]
    G -->|No| I[Refine Plan]
    I --> F
```

## 🔧 Configuración de Hooks

Los hooks en `.claude-settings.json` automatizan:
- Detección de PRD al iniciar
- Validación antes de planificar
- Resumen después del análisis
- Verificación antes de codear

## 🤖 Integración con MCPs

- **Context-7**: Obtiene documentación actualizada durante análisis
- **Playwright**: Valida feasibilidad técnica con POCs
- **WebSearch**: Investiga mejores prácticas actuales

## ✅ Ventajas del Sistema

1. **Planificación antes que código**: Evita reescrituras costosas
2. **Decisiones informadas**: Usa documentación actualizada vía MCPs
3. **Riesgos identificados temprano**: Ahorra tiempo y recursos
4. **Plan claro y medible**: Todos saben qué esperar
5. **Automatización inteligente**: Hooks guían el proceso

## 📁 Estructura de Carpetas

```
.cloud/          # Comandos de análisis y planificación
.analysis/       # Templates para análisis
.planning/       # Templates para planes
.workflows/      # Flujos de trabajo documentados
.hooks/          # Scripts de automatización
.mcp-strategies/ # Estrategias de uso de MCPs
.output/         # Resultados del análisis (generado)
```

## 🎓 Mejores Prácticas

1. **Siempre** agregar PRD antes de iniciar
2. **Nunca** saltear la fase de análisis
3. **Validar** decisiones técnicas con documentación actual
4. **Documentar** todas las decisiones en `.output/`
5. **Revisar** el plan antes de codear

## 🔄 Actualización

Esta carpeta semilla se mantiene genérica. Para actualizarla:

```bash
git pull origin main
# Los cambios son solo de estructura/comandos
# No afectan código específico de proyectos
```

---

*Sistema diseñado para Agentic Coding con Claude Code*
