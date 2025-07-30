# Decidir Stack Tecnológico

Toma decisión informada del stack basada en análisis PRD y research actualizado.

## Prerequisitos
- `.output/current/analysis.md` debe existir
- Requerimientos claros de performance, escalabilidad, team skills

## Proceso de Decisión

### 1. Matrix de Evaluación
Para cada opción evaluar (1-10):
- **Fit con requerimientos** del PRD
- **Performance** para casos de uso específicos  
- **Developer experience** para el team
- **Ecosystem maturity** y community support
- **Long-term maintainability**
- **Deployment complexity**

### 2. Context-7 Research

#### Laravel vs Alternatives
```
/laravel/framework topic="performance,scalability,ecosystem"
/symfony/symfony topic="enterprise,architecture"
/codeigniter4/codeigniter4 topic="simplicity,learning-curve"
```

#### Next.js vs React Alternatives  
```
/vercel/next.js topic="ssr,performance,deployment"
/facebook/react topic="spa,state-management" 
/vitejs/vite topic="build-performance,dev-experience"
```

#### Python Framework Decision
```
/django/django topic="admin,orm,scalability"
/pallets/flask topic="microservices,flexibility"
/tiangolo/fastapi topic="async,api-performance"
```

### 3. Stack-Specific Considerations

#### Full-Stack Laravel
**Pros**: Monolithic simplicity, Eloquent ORM, artisan CLI
**Cons**: Frontend limitations, PHP ecosystem
**Best for**: CRUD apps, admin panels, traditional web apps

#### Laravel API + Next.js  
**Pros**: Best of both worlds, modern frontend, robust backend
**Cons**: Complexity, deployment overhead, state synchronization
**Best for**: Modern SPAs, mobile apps, complex UIs

#### Full-Stack Next.js
**Pros**: TypeScript ecosystem, Vercel deployment, full-stack JS
**Cons**: Node.js limitations, database ORM options
**Best for**: Content sites, e-commerce, modern web apps

#### React SPA + Laravel API
**Pros**: Frontend flexibility, mature backend, clear separation
**Cons**: CORS complexity, auth complexity, more moving parts
**Best for**: Complex frontends, multiple clients, team specialization

## Decision Framework

### High Performance Requirements
1. **Next.js** (SSR/SSG) or **Laravel + Octane**
2. Consider **FastAPI** for API-heavy workloads
3. **React** with optimized build pipeline

### Rapid Development
1. **Laravel** with Livewire for full-stack
2. **Next.js** with Prisma for modern stack
3. **Django** for Python-centric teams

### Enterprise/Scale Requirements  
1. **Laravel** with proper architecture patterns
2. **Next.js** with proper caching strategies
3. **Django** with async support

## Output Structure

Generar `.output/v1.0_stack-decision.md`:
- **Recommended stack** con justificación detallada
- **Alternative options** con trade-offs
- **Architecture overview** de alto nivel
- **Integration plan** entre componentes elegidos
- **Risk assessment** y mitigation strategies