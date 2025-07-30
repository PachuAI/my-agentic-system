# Estrategia: Recopilación de Documentación con Context-7

## Cuándo Usar Context-7

### Durante Análisis PRD
- **Para qué**: Entender dominios técnicos mencionados
- **Cómo**: Buscar documentación de frameworks/librerías mencionados
- **Ejemplo**: PRD menciona "real-time notifications" → buscar WebSocket libraries

### Durante Recomendación de Stack
- **Para qué**: Obtener documentación actualizada de opciones tecnológicas
- **Cómo**: Comparar múltiples frameworks con documentación fresh
- **Ejemplo**: Comparar Next.js vs Nuxt.js vs SvelteKit para SPA

### Durante Diseño de Arquitectura
- **Para qué**: Validar patrones arquitectónicos y mejores prácticas
- **Cómo**: Buscar architecture patterns para el stack elegido
- **Ejemplo**: Microservices patterns para Node.js + Docker

## Estrategia de Búsqueda

### 1. Identificación de Librerías
```bash
# Proceso recomendado:
1. Usar resolve-library-id para encontrar la librería exacta
2. Verificar que es la librería correcta
3. Usar get-library-docs con tópicos específicos
```

### 2. Búsqueda por Tópicos
**Para frameworks principales:**
- `authentication` - Sistemas de auth
- `routing` - Configuración de rutas
- `state-management` - Manejo de estado
- `performance` - Optimizaciones
- `testing` - Estrategias de testing
- `deployment` - Configuración de deploy

**Para librerías específicas:**
- `api-design` - Diseño de APIs
- `database-integration` - Conexión con BD
- `error-handling` - Manejo de errores
- `security` - Mejores prácticas de seguridad

### 3. Tokens por Fase
- **Análisis PRD**: 5000-8000 tokens por búsqueda
- **Stack Decision**: 10000-15000 tokens (múltiples frameworks)
- **Architecture**: 8000-12000 tokens por componente
- **Implementation**: 5000-8000 tokens por feature

## Patterns de Uso Efectivo

### Pattern 1: Comparative Analysis
```bash
# Comparar múltiples opciones
1. resolve-library-id "react state management"
2. get-library-docs "/facebook/react" topic="state-management" tokens=8000
3. resolve-library-id "vue state management" 
4. get-library-docs "/vuejs/vue" topic="state-management" tokens=8000
5. Comparar y documentar diferencias
```

### Pattern 2: Deep Dive
```bash
# Profundizar en una tecnología específica
1. get-library-docs "/vercel/next.js" topic="performance" tokens=12000
2. get-library-docs "/vercel/next.js" topic="deployment" tokens=8000
3. get-library-docs "/vercel/next.js" topic="testing" tokens=8000
4. Consolidar información para decisión
```

### Pattern 3: Architecture Validation
```bash
# Validar patrones arquitectónicos
1. get-library-docs "/expressjs/express" topic="middleware" tokens=10000
2. get-library-docs "/nestjs/nest" topic="architecture" tokens=10000
3. Comparar approaches y elegir el apropiado
```

## Mejores Prácticas

### Do's
- **Siempre** usar resolve-library-id primero
- **Especificar** tópicos relevantes para obtener info focused
- **Documentar** hallazgos key en archivos de output
- **Comparar** múltiples opciones antes de decidir
- **Validar** compatibilidad entre tecnologías elegidas

### Don'ts
- **No** buscar sin tópico específico (desperdicia tokens)
- **No** asumir que la primera opción es la mejor
- **No** ignorar considerations de performance/security
- **No** olvidar documentar el "por qué" de las decisiones

## Templates de Preguntas

### Para Frameworks
- "What are the key features of [framework]?"
- "How does [framework] handle [specific-need]?"
- "What are the performance characteristics of [framework]?"
- "What are common patterns for [use-case] in [framework]?"
- "How does [framework] compare to [alternative] for [use-case]?"

### Para Architecture
- "What are best practices for [pattern] in [technology]?"
- "How to implement [feature] following [framework] conventions?"
- "What are security considerations for [architecture] pattern?"
- "How to handle [non-functional-requirement] in [stack]?"

## Casos de Uso Comunes

### Caso 1: Elegir Frontend Framework
1. Analizar requerimientos (SPA, SSR, SEO, etc.)
2. Buscar documentación de 3-4 opciones principales
3. Comparar en matriz de decisión
4. Validar ecosystem y community support
5. Documentar elección con justificación

### Caso 2: Database Selection
1. Identificar data patterns del PRD
2. Buscar documentation de opciones (SQL vs NoSQL)
3. Evaluar scalability y performance needs
4. Considerar operational complexity
5. Documentar trade-offs

### Caso 3: Authentication Strategy
1. Analizar user types y security requirements
2. Buscar auth patterns para el stack elegido
3. Evaluar third-party vs custom solutions
4. Considerar compliance requirements
5. Documentar implementación approach

## Integration con Otros MCPs

### Con WebSearch
- Context-7 para documentación oficial
- WebSearch para community feedback y comparisons
- Context-7 para implementation details
- WebSearch para real-world case studies

### Con Playwright
- Context-7 para testing strategies
- Playwright para validar performance claims
- Context-7 para deployment docs
- Playwright para verify deployed applications

## Output Documentation

Para cada búsqueda importante, documentar:

```markdown
## Context-7 Research: [Topic]

### Query Used
- Library: [library-id]
- Topic: [topic]
- Tokens: [token-count]

### Key Findings
- [Finding 1]
- [Finding 2]
- [Finding 3]

### Decision Impact
- How this affects our tech stack choice
- How this affects our architecture
- How this affects our implementation plan

### Follow-up Needed
- [ ] Additional research needed
- [ ] Validation required
- [ ] Questions for client
```

---

*Estrategia optimizada para maximizar valor de Context-7*