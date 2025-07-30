# Analizar PRD

Extrae y estructura todos los requerimientos del PRD de forma sistemática.

## Proceso

1. **Leer PRD completo** y validar completitud
2. **Extraer requerimientos** funcionales y no funcionales  
3. **Identificar componentes** principales por stack
4. **Estimar complejidad** inicial (1-10 por componente)
5. **Listar integraciones** externas necesarias
6. **Priorizar features** (MVP vs Future)
7. **Documentar asunciones** y preguntas críticas

## Stack-Specific Analysis

### Laravel Projects
- **Backend**: Controllers, Models, Services, Jobs
- **Frontend**: Blade views, Livewire, Inertia
- **Database**: Migrations, Eloquent relationships
- **APIs**: Resource controllers, API authentication

### Next.js Projects  
- **App Structure**: App router, pages, layouts
- **Rendering**: SSR, SSG, CSR strategies
- **State**: Server/client components, state management
- **APIs**: Route handlers, middleware, auth

### React Projects
- **Components**: Hooks, context, state patterns
- **Routing**: React Router, navigation patterns
- **State**: Redux, Zustand, Context API
- **UI**: Component libraries, styling approaches

### Python Web Projects
- **Framework**: Django/Flask/FastAPI patterns
- **Models**: ORM, database design
- **Views**: Templates, API serializers
- **Deployment**: WSGI/ASGI, containerization

## Context-7 Research Areas

Usar Context-7 para investigar:
- **Domain patterns** para el tipo de aplicación
- **Authentication** strategies para el stack elegido
- **Performance** benchmarks y optimizations
- **Testing** frameworks y patterns recomendados

## Output

Generar `.output/v1.0_analysis.md` usando template optimizado con:
- Requerimientos estructurados por prioridad
- Componentes mapeados al stack detectado
- Estimaciones de complejidad justificadas
- Plan de research para decisión de stack