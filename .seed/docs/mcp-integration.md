# MCP Integration Guide

Guía para integrar nuevos Model Context Protocol servers en el sistema Agentic Seed.

## MCPs Incluidos

### Context-7 (Documentación)
**Uso**: Obtener documentación actualizada de frameworks y librerías  
**Cuándo**: Durante análisis, decisión de stack, y diseño de arquitectura  
**Comandos**: `resolve-library-id`, `get-library-docs`

### Playwright (Testing)
**Uso**: Automatización de testing E2E y validación de UIs  
**Cuándo**: Durante desarrollo y QA  
**Comandos**: `browser_navigate`, `browser_click`, `browser_type`, etc.

### WebSearch (Research)
**Uso**: Investigación de tendencias, mejores prácticas, casos de éxito  
**Cuándo**: Durante análisis y validación de decisiones  
**Comandos**: Búsquedas contextuales

## Integrar Nuevo MCP

### 1. Identificar Caso de Uso

Antes de integrar, definir:
- **¿Qué problema resuelve?** Específico para Laravel/Next.js/React/Python
- **¿En qué fase se usa?** Análisis, desarrollo, testing, deployment
- **¿Con qué comandos se integra?** `/analyze`, `/decide-stack`, etc.
- **¿Qué valor agrega?** Debe ser significativo para el workflow

### 2. Configuración en Claude Code

#### .claude-settings.json
```json
{
  "mcp_servers": {
    "nuevo-mcp": {
      "command": "node",
      "args": ["/path/to/mcp-server.js"],
      "env": {
        "API_KEY": "your-api-key"
      }
    }
  }
}
```

#### Variables de Entorno
```bash
# .env.local (no commitar)
NUEVO_MCP_API_KEY=sk-xxx
NUEVO_MCP_BASE_URL=https://api.ejemplo.com
```

### 3. Integración en Comandos

#### Ejemplo: MCP de Database Design
```markdown
# .seed/commands/decide-stack.md

## Database Research con nuevo MCP

### Uso del MCP database-advisor
Usar database-advisor para obtener recomendaciones:

Para proyectos Laravel:
- Consultar patrones de Eloquent
- Evaluar PostgreSQL vs MySQL para el caso de uso
- Obtener recommendations de indexing

Para proyectos Next.js:
- Evaluar Prisma vs DrizzleORM vs direct SQL
- Considerar edge databases (PlanetScale, Neon)
- Analizar trade-offs de ORMs

Para proyectos Python:
- Django ORM vs SQLAlchemy patterns
- Async database support evaluation
- Migration strategy recommendations

### Integration Pattern
```javascript
// Ejemplo de llamada al MCP
const dbRecommendation = await mcp.call('database-advisor', {
  stack: 'laravel',
  expectedLoad: 'medium',
  dataComplexity: 'high',
  consistency: 'strong'
});
```

### Output Integration
Los resultados se integran en `.output/stack-decision.md` en la sección "Database Decision"
```

### 4. Hooks Integration

#### Stack-Specific MCP Usage
```bash
# .seed/automation/stack-detector.sh

# Detectar cuándo usar el nuevo MCP
case $AGENTIC_STACK in
    "laravel")
        if [ "$AGENTIC_API_MODE" = "true" ]; then
            export AGENTIC_USE_API_ADVISOR="true"
            log "API advisor MCP enabled for Laravel API"
        fi
        ;;
    "nextjs")
        if [ "$AGENTIC_APP_ROUTER" = "true" ]; then
            export AGENTIC_USE_NEXTJS_ADVISOR="true" 
            log "Next.js advisor MCP enabled"
        fi
        ;;
esac
```

#### Validation Hooks
```bash
# .seed/automation/after-code-change.sh

# Usar MCP para validación específica
if [ "$AGENTIC_USE_API_ADVISOR" = "true" ]; then
    # Llamar al MCP para validar API design
    echo "🔍 Validating API design with MCP..."
fi
```

### 5. Error Handling

#### MCP Availability Check
```bash
# .seed/automation/check-mcp-availability.sh
#!/bin/bash

check_mcp_available() {
    local mcp_name=$1
    
    # Verificar que el MCP esté configurado y responda
    if ! timeout 5s claude-mcp-client check "$mcp_name" >/dev/null 2>&1; then
        warn "MCP $mcp_name not available - Falling back to manual process"
        return 1
    fi
    
    return 0
}

# Usar en comandos
if check_mcp_available "database-advisor"; then
    # Usar MCP
    log "Using database-advisor MCP for recommendations"
else
    # Fallback manual
    log "Manual database selection required"
fi
```

#### Graceful Degradation
```markdown
# En comandos .seed/commands/

## Fallback Strategy
Si el MCP no está disponible:

1. **Manual Research**: Usar Context-7 para buscar documentación
2. **Community Input**: Consultar Stack Overflow, Reddit, etc.
3. **Default Patterns**: Usar configuraciones probadas para el stack
4. **Documentation**: Documentar la decisión manual en output
```

## Patrones de Integración

### 1. Research MCPs (Como Context-7)
**Uso**: Obtener información externa actualizada  
**Integration points**: 
- `/analyze` - Research de dominio
- `/decide-stack` - Documentación de tecnologías
- `/design-arch` - Patrones arquitectónicos

**Pattern**:
```bash
# Research phase
research_results=$(mcp_call "research-mcp" --topic="$domain" --stack="$stack")
# Integrate in analysis
echo "$research_results" >> .output/research-findings.md
```

### 2. Validation MCPs (Como Playwright)
**Uso**: Validar código, UI, performance, etc.  
**Integration points**:
- Hooks automáticos después de cambios
- Comandos de validación manual
- Pre-commit checks

**Pattern**:
```bash
# Validation in hooks
if is_ui_file "$CLAUDE_TOOL_PATH"; then
    mcp_call "ui-validator" --file="$CLAUDE_TOOL_PATH" --stack="$AGENTIC_STACK"
fi
```

### 3. Generation MCPs 
**Uso**: Generar código, configuraciones, tests  
**Integration points**:
- `/setup-project` - Generar boilerplate
- Durante desarrollo - Generar tests, docs
- Deployment - Generar configuraciones

**Pattern**:
```bash
# Code generation
mcp_call "code-generator" \
    --template="laravel-api-controller" \
    --model="User" \
    --actions="index,show,store,update,destroy"
```

### 4. Analysis MCPs
**Uso**: Analizar código, performance, security  
**Integration points**:
- Hooks automáticos en commits
- Comandos de análisis periódico
- Pre-production checks

**Pattern**:
```bash
# Security analysis
security_report=$(mcp_call "security-analyzer" --path="." --stack="$AGENTIC_STACK")
if [ "$security_report" != "PASSED" ]; then
    echo "Security issues found: $security_report"
fi
```

## Testing MCP Integration

### 1. Unit Testing MCP Calls
```bash
# .seed/tests/mcp-integration.sh
#!/bin/bash

test_mcp_availability() {
    local mcp_name="database-advisor"
    
    if check_mcp_available "$mcp_name"; then
        echo "✅ $mcp_name available"
    else
        echo "❌ $mcp_name not available"
        return 1
    fi
}

test_mcp_response() {
    local response=$(mcp_call "database-advisor" --stack="laravel" --test=true)
    
    if [[ "$response" == *"recommendation"* ]]; then
        echo "✅ MCP response valid"
    else
        echo "❌ MCP response invalid: $response"
        return 1
    fi
}
```

### 2. Integration Testing
```bash
# Test completo de workflow con MCP
test_full_workflow() {
    # Setup test environment
    echo "# Test Project" > PRD.md
    
    # Run analysis with MCP
    claude_command "/analyze"
    
    # Verify MCP was used
    if grep -q "database-advisor" .output/current/analysis.md; then
        echo "✅ MCP integrated in analysis"
    else
        echo "❌ MCP not used in analysis"
        return 1
    fi
}
```

## Documentación del MCP

### README Section
Para cada MCP integrado, agregar sección en README:

```markdown
### 🔌 [MCP Name] Integration
**Purpose**: [What it does]  
**Usage**: [When it's used in the workflow]  
**Commands**: [Specific commands that use it]  
**Benefits**: [Value it adds to the workflow]

**Example**:
```bash
# Used automatically in /decide-stack
/decide-stack  # Calls database-advisor for DB recommendations
```
```

### Hook Documentation
```markdown
# .seed/docs/hook-variables.md

## MCP-Specific Variables

### Database Advisor MCP
```bash
$AGENTIC_USE_DB_ADVISOR       # true/false - MCP available and enabled
$AGENTIC_DB_RECOMMENDATION    # Output from database advisor
$AGENTIC_DB_ADVISOR_VERSION   # Version of MCP used
```
```

## Maintenance

### Version Management
```bash
# Verificar versions de MCPs
mcp_version_check() {
    echo "=== MCP Versions ==="
    
    for mcp in context7 playwright database-advisor; do
        version=$(mcp_call "$mcp" --version 2>/dev/null || echo "unknown")
        echo "$mcp: $version"
    done
}
```

### Performance Monitoring
```bash
# Monitor MCP performance
mcp_performance_log() {
    local mcp_name=$1
    local start_time=$(date +%s.%N)
    
    # MCP call here
    mcp_call "$mcp_name" "$@"
    
    local end_time=$(date +%s.%N)
    local duration=$(echo "$end_time - $start_time" | bc)
    
    echo "MCP $mcp_name took ${duration}s" >> .agentic-mcp-performance.log
}
```

## Ejemplos de MCPs Útiles

### Para Laravel
- **Laravel-specific MCP**: Eloquent patterns, Artisan commands
- **PHP Security MCP**: Security best practices, vulnerability scanning
- **Laravel Performance MCP**: Query optimization, caching strategies

### Para Next.js
- **Next.js Optimizer MCP**: Bundle analysis, performance recommendations
- **React Patterns MCP**: Component patterns, hooks best practices
- **SEO Analyzer MCP**: Meta tags, structured data, performance

### Para Python
- **Django Patterns MCP**: Model patterns, view optimizations
- **Python Security MCP**: Security audit, dependency checking
- **FastAPI Optimizer MCP**: Async patterns, performance tuning

---

*MCP Integration Guide for Agentic Seed System*  
*Focus: Laravel, Next.js, React, Python workflows*  
*Updated: $(date)*