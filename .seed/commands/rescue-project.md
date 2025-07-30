# Rescue Existing Project

Analiza proyecto existente y crea plan de mejora sistemático para llevarlo a estándares de producción.

## Prerequisitos
- Proyecto con código existente (package.json, composer.json, manage.py, etc.)
- Acceso de lectura a todos los archivos del proyecto
- Git repository inicializado (recomendado para análisis de actividad)

## Proceso de Rescue

### 1. **Análisis de Codebase**
- Detectar stack tecnológico y versiones
- Mapear estructura de archivos y organización
- Identificar patrones arquitectónicos implementados
- Contar líneas de código, archivos, y complejidad

### 2. **Reverse Engineering**
- Extraer funcionalidades implementadas del código
- Identificar user stories basadas en features existentes
- Mapear flujos de datos y integraciones
- Documentar APIs y endpoints existentes

### 3. **Quality Assessment**
- Analizar cobertura de tests existente
- Identificar code smells y technical debt
- Evaluar dependencias (actualizadas, vulnerabilidades)
- Medir performance potencial y bottlenecks

### 4. **Security Audit**
- Buscar vulnerabilidades comunes por stack
- Verificar manejo de datos sensibles
- Analizar configuraciones de seguridad
- Identificar exposiciones no intencionadas

### 5. **Architecture Analysis**
- Documentar arquitectura actual (diagrams en texto)
- Identificar patrones vs anti-patrones
- Evaluar escalabilidad de la estructura actual
- Comparar con best practices del stack

## Stack-Specific Analysis

### Laravel Projects
**Codebase Analysis:**
- Controllers, Models, Migrations count
- Blade views vs API-only detection
- Service Provider usage patterns
- Middleware and Route organization

**Quality Metrics:**
- Eloquent relationship complexity  
- Query optimization opportunities (N+1 detection)
- Artisan command usage
- Cache strategy implementation

**Security Focus:**
- CSRF protection implementation
- Input validation patterns
- Authentication/authorization setup
- Environment variable security

### Next.js Projects
**Codebase Analysis:**
- Pages vs App Router detection
- API routes implementation
- Component organization patterns
- Static vs Dynamic rendering usage

**Performance Analysis:**  
- Bundle size analysis
- Image optimization usage
- Code splitting implementation
- Caching strategies employed

**SEO & Web Vitals:**
- Meta tags implementation
- Structured data usage  
- Core Web Vitals optimization
- Accessibility compliance

### React SPA Projects
**Architecture Assessment:**
- State management patterns (Redux, Context, local)
- Component composition patterns
- Custom hooks usage
- Performance optimization techniques

**Build Analysis:**
- Bundle size and splitting
- Tree shaking effectiveness
- Development vs production configurations
- Testing setup and coverage

### Python Web Projects
**Framework Analysis:**
- Django: Apps structure, admin usage, ORM complexity
- Flask: Blueprint organization, extension usage
- FastAPI: Async usage, dependency injection patterns

**Code Quality:**
- PEP 8 compliance
- Type hints usage
- Docstring coverage
- Error handling patterns

## Research Integration

### Context-7 Usage
Durante el análisis, usar Context-7 para:
- Obtener best practices del stack detectado
- Comparar patrones actuales vs recomendados
- Investigar migration paths para versiones antiguas
- Buscar security recommendations específicas

### Example Context-7 queries:
```bash
# Para Laravel detectado
resolve-library-id "laravel/framework"
get-library-docs "/laravel/framework" topic="security,performance,testing" tokens=10000

# Para Next.js detectado  
resolve-library-id "next.js"
get-library-docs "/vercel/next.js" topic="optimization,best-practices" tokens=12000
```

## Outputs Generated

### 1. Project Analysis Report
**Archivo:** `.output/v1.0.0_project-analysis.md`
- Current state comprehensive overview
- Technical metrics and statistics
- Architecture documentation
- Identified issues by priority

### 2. Reverse-Engineered PRD
**Archivo:** `.output/v1.0.0_reverse-prd.md`  
- Inferred product requirements from code
- User stories extracted from features
- Technical requirements documented
- Assumptions and unknowns listed

### 3. Improvement Plan
**Archivo:** `.output/v1.0.0_improvement-plan.md`
- Prioritized technical debt items
- Security vulnerability fixes
- Performance optimization tasks  
- Testing strategy to implement

### 4. Migration Roadmap (if needed)
**Archivo:** `.output/v1.0.0_migration-plan.md`
- Framework/dependency upgrades needed
- Breaking changes to handle
- Gradual migration strategy
- Rollback procedures

## Quality Gates

### Before Starting Analysis
- [ ] Project has recognizable structure
- [ ] Can detect primary technology stack
- [ ] Has read access to source files
- [ ] Git history available (preferred)

### After Analysis Complete
- [ ] All major files and patterns documented
- [ ] Security issues identified and categorized
- [ ] Technical debt prioritized by impact
- [ ] Clear next steps provided

### Ready for Improvement
- [ ] Stakeholder buy-in for improvement plan
- [ ] Resources allocated for technical debt
- [ ] Backup/rollback strategy prepared
- [ ] Testing strategy for changes defined

## Success Metrics

### Documentation Coverage
- **Architecture**: Current system fully documented
- **APIs**: All endpoints cataloged
- **Database**: Schema and relationships mapped
- **Dependencies**: All packages inventoried

### Issue Identification
- **High Priority**: Critical security/performance issues found
- **Medium Priority**: Code quality improvements identified  
- **Low Priority**: Nice-to-have optimizations listed
- **Quick Wins**: Easy improvements with high impact

### Improvement Planning
- **Realistic Timeline**: Tasks estimated with effort
- **Risk Assessment**: Changes evaluated for risk
- **Resource Planning**: Team capacity considered
- **Business Impact**: Improvements tied to value

## Integration with New Project Flow

### After Rescue Analysis
If rescue reveals need for major changes:

1. **Use generated reverse-PRD**: Refine it with business stakeholders
2. **Run standard analysis**: `/analyze` with improved PRD
3. **Compare architectures**: Current vs recommended
4. **Create migration plan**: Gradual transition strategy

### Hybrid Approach
```bash
/rescue-project          # Understand current state
# Refine reverse-engineered PRD.md with stakeholders  
/analyze                 # Re-analyze with improved requirements
/design-arch             # Design target architecture  
/plan-dev                # Create migration + improvement plan
```

## Common Rescue Scenarios

### Scenario 1: MVP that Needs Productionization
- Focus on security hardening
- Add comprehensive testing
- Implement proper CI/CD
- Add monitoring and logging

### Scenario 2: Legacy Code Modernization  
- Framework/dependency upgrades
- Architecture pattern improvements
- Performance optimization
- Code quality standardization

### Scenario 3: Inherited Project Documentation
- Reverse engineer all functionality
- Create missing documentation
- Establish development standards
- Set up team workflows

---

*Rescue existing projects and bring them to production standards*
*Compatible with Laravel, Next.js, React, Python stacks*