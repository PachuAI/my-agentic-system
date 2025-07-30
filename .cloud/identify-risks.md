# Identificar Riesgos

Realiza un análisis exhaustivo de riesgos técnicos:

## 1. Riesgos Técnicos
- Complejidad de integraciones
- Escalabilidad de la arquitectura propuesta
- Performance bottlenecks potenciales
- Dependencias de terceros
- Compatibilidad entre tecnologías
- Curva de aprendizaje del equipo

## 2. Riesgos de Proyecto
- Ambigüedades en requerimientos
- Cambios de scope potenciales
- Dependencias externas (APIs, servicios)
- Plazos poco realistas
- Recursos insuficientes

## 3. Riesgos de Seguridad
- Vulnerabilidades conocidas del stack
- Manejo de datos sensibles
- Autenticación y autorización
- Exposición de APIs
- Compliance y regulaciones

## 4. Riesgos Operacionales
- Single points of failure
- Backup y disaster recovery
- Monitoring y alertas
- Deployment y rollback
- Mantenimiento a largo plazo

## 5. Para Cada Riesgo Identificado
- **Probabilidad**: Alta/Media/Baja
- **Impacto**: Alto/Medio/Bajo
- **Descripción**: Qué puede salir mal
- **Señales de alerta**: Cómo detectarlo temprano
- **Mitigación**: Cómo reducir probabilidad
- **Contingencia**: Qué hacer si ocurre
- **Responsable**: Quién monitorea este riesgo

## 6. Plan de Monitoreo
- Checkpoints para revisar riesgos
- Métricas para detectar problemas
- Proceso de escalación
- Actualización del análisis

## Output
Guarda en `.output/risk-assessment.md` priorizando riesgos por impacto x probabilidad