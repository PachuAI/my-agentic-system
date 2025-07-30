# Instrucciones de Inicialización para Claude Code

Cuando se clone este repositorio para un nuevo proyecto:

1. **BUSCAR Y LEER** el archivo PRD.md (o similar) en la raíz
2. **ANALIZAR** toda la estructura de carpeta semilla
3. **NO ESCRIBIR CÓDIGO** hasta completar el análisis
4. **EJECUTAR** los siguientes comandos en orden:
   - `/analyze-prd` - Para extraer requerimientos
   - `/tech-stack-recommendation` - Para elegir tecnologías
   - `/architecture-design` - Para diseñar arquitectura
   - `/create-action-plan` - Para generar plan detallado

## Principios Fundamentales
- Planificar antes de codear
- Validar decisiones técnicas con documentación actualizada
- Crear un plan claro y medible
- Identificar riesgos temprano
- Establecer arquitectura sólida desde el inicio

## Outputs Esperados
Todos los análisis deben guardarse en `.output/` con nombres descriptivos:
- `prd-analysis.md`
- `tech-stack-decision.md`
- `architecture-design.md`
- `action-plan.md`
- `risk-assessment.md`

## Flujo de Trabajo
1. **Análisis PRD** → Entender completamente el requerimiento
2. **Research Técnico** → Usar Context-7 para documentación actualizada
3. **Decisión de Stack** → Justificar elección tecnológica
4. **Diseño Arquitectónico** → Definir estructura sin implementar
5. **Plan de Acción** → Crear roadmap detallado
6. **Validación** → Confirmar que todo está claro antes de codear

## Herramientas Disponibles
- **Context-7**: Para documentación de frameworks/librerías
- **Playwright**: Para POCs de UI/UX
- **WebSearch**: Para research de mejores prácticas
- **Hooks**: Para automatización de tareas recurrentes