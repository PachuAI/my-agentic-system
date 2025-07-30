# Estimar Complejidad

Analiza y estima la complejidad del proyecto:

## 1. Complejidad por Componente
Evalúa cada componente en escala 1-10:

### Frontend
- **UI/UX Complexity**: Diseños custom, animaciones, responsive
- **State Management**: Complejidad del estado global
- **Routing**: Navegación y guards
- **Performance**: Optimizaciones necesarias

### Backend
- **API Complexity**: Número y complejidad de endpoints
- **Business Logic**: Reglas de negocio complejas
- **Data Processing**: Transformaciones y validaciones
- **Integrations**: APIs externas y servicios

### Data Layer
- **Schema Complexity**: Relaciones y restricciones
- **Queries**: Consultas complejas y optimizaciones
- **Migrations**: Cambios de esquema
- **Performance**: Índices y optimizaciones

## 2. Factores de Complejidad
- **Unknowns**: Qué no sabemos que no sabemos
- **Dependencies**: Número de dependencias externas
- **Integrations**: Complejidad de integraciones
- **Scale**: Volumen de datos/usuarios esperado
- **Compliance**: Requerimientos regulatorios

## 3. Estimación de Esfuerzo
Para cada componente/feature:
- **Investigación**: Tiempo para entender requerimientos
- **Diseño**: Tiempo para planificar implementación
- **Desarrollo**: Tiempo de coding
- **Testing**: Tiempo para tests unitarios e integración
- **Debug**: Buffer para corrección de bugs
- **Documentation**: Tiempo para documentar

## 4. Métricas de Complejidad
- **Lines of Code Estimadas**: Aproximación por componente
- **Number of Files**: Archivos estimados
- **API Endpoints**: Número de endpoints
- **Database Tables**: Tablas y relaciones
- **External Services**: Integraciones necesarias

## 5. Factores de Riesgo en Estimación
- Experiencia del equipo con el stack
- Claridad de requerimientos
- Estabilidad de tecnologías elegidas
- Complejidad de testing
- Deployment complexity

## Output
Guarda en `.output/complexity-estimation.md` con desglose detallado y justificación de cada estimación