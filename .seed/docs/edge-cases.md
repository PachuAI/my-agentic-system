# Edge Cases & Troubleshooting

Documentación de casos especiales y soluciones para tu stack (Laravel, Next.js, React, Python).

## Stack Detection Edge Cases

### 1. Proyecto Fullstack Laravel + React/Vue
**Situación**: Proyecto con `composer.json` Y `package.json`

```bash
# Detección automática
if [ -f "composer.json" ] && [ -f "package.json" ]; then
    if grep -q "laravel/framework" composer.json; then
        if grep -q "inertiajs" composer.json || grep -q "@inertiajs" package.json; then
            STACK_TYPE="laravel-inertia"
        elif grep -q "livewire" composer.json; then
            STACK_TYPE="laravel-livewire-alpine"
        else
            STACK_TYPE="laravel-traditional-js"
        fi
    fi
fi
```

**Optimizaciones aplicadas**:
- Hooks validan tanto PHP como JS/TS
- Tests ejecutan PHPUnit Y Jest/Vitest
- Linting aplica PHP CS Fixer Y ESLint

### 2. Next.js con Multiple Backends
**Situación**: Next.js frontend que consume múltiples APIs

```bash
# Detectar configuración de múltiples APIs
if [ -f "next.config.js" ]; then
    if grep -q "rewrites\|proxy" next.config.js; then
        export AGENTIC_MULTI_API="true"
        log "Multiple API backends detected"
    fi
fi
```

**Consideraciones**:
- Variables de entorno para múltiples endpoints
- Testing con mocks de múltiples servicios
- CORS handling más complejo

### 3. React SPA con Laravel API Separado
**Situación**: Repos separados pero desarrollo conjunto

```bash
# Estructura de directorios típica
project/
├── frontend/     # React SPA
│   ├── package.json
│   └── src/
└── backend/      # Laravel API
    ├── composer.json
    └── app/

# Detección en hooks
if [ -d "../backend" ] && [ -f "../backend/composer.json" ]; then
    export AGENTIC_SEPARATE_BACKEND="true"
    export AGENTIC_BACKEND_PATH="../backend"
fi
```

### 4. Django con React Frontend Integrado
**Situación**: Django sirve React desde `static/` o `templates/`

```bash
# Detección
if [ -f "manage.py" ] && [ -d "frontend" ] && [ -f "frontend/package.json" ]; then
    export AGENTIC_DJANGO_REACT="true"
    log "Django + React integration detected"
fi
```

## Migration Edge Cases

### 1. Laravel Mix → Vite Migration
**Problema**: Proyecto tiene `webpack.mix.js` pero quiere migrar a Vite

```bash
# Detección de migración necesaria
if [ -f "webpack.mix.js" ] && [ ! -f "vite.config.js" ]; then
    warn "Laravel Mix detected - Consider migrating to Vite for better performance"
    warn "Guide: https://laravel.com/docs/vite"
    export AGENTIC_MIGRATION_NEEDED="mix-to-vite"
fi
```

**Acciones recomendadas**:
- Sugerir migración en análisis
- Documentar proceso en plan de desarrollo
- Incluir migración como tarea si es apropiado

### 2. Next.js Pages → App Router
**Problema**: Proyecto Next.js con Pages Router que debe migrar

```bash
# Detección de migración
if [ -d "pages" ] && [ ! -d "app" ]; then
    if [ "$AGENTIC_FRAMEWORK_VERSION" \> "13" ]; then
        warn "Next.js 13+ detected with Pages Router"
        warn "Consider migrating to App Router for better performance"
        export AGENTIC_MIGRATION_NEEDED="pages-to-app"
    fi
fi
```

### 3. Django 3.x → 4.x Async Views
**Problema**: Django version antigua que necesita async support

```bash
# Verificar version y async usage
if command -v python >/dev/null 2>&1; then
    DJANGO_VERSION=$(python -c "import django; print('.'.join(map(str, django.VERSION[:2])))" 2>/dev/null || echo "unknown")
    
    if [ "$DJANGO_VERSION" \< "4.1" ] && grep -r "async def\|await " . --include="*.py" >/dev/null 2>&1; then
        warn "Async code detected in Django < 4.1"
        warn "Consider upgrading Django for better async support"
        export AGENTIC_MIGRATION_NEEDED="django-async-upgrade"
    fi
fi
```

## Development Environment Edge Cases

### 1. Windows con WSL
**Problema**: Claude Code ejecutándose en Windows pero proyecto en WSL

```bash
# Detección de WSL desde Windows
if [[ "$PWD" == /mnt/* ]] || [[ "$WSL_DISTRO_NAME" ]]; then
    export AGENTIC_WSL_MODE="true"
    log "WSL environment detected"
    
    # Ajustes específicos para WSL
    export AGENTIC_NODE_MODULES_CACHE="/tmp/node_modules_cache"
    export AGENTIC_COMPOSER_CACHE="/tmp/composer_cache"
fi
```

**Optimizaciones WSL**:
- Cache de node_modules en tmpfs
- Paths adjustments para cross-platform
- Performance tuning para I/O

### 2. Docker Development Environment
**Problema**: Proyecto ejecutándose dentro de containers

```bash
# Detección Docker
if [ -f "docker-compose.yml" ] || [ -f "Dockerfile" ]; then
    export AGENTIC_DOCKER_MODE="true"
    
    # Verificar si estamos DENTRO de un container
    if [ -f "/.dockerenv" ] || grep -q "docker\|lxc" /proc/1/cgroup 2>/dev/null; then
        export AGENTIC_INSIDE_CONTAINER="true"
        log "Running inside Docker container"
    fi
fi
```

**Ajustes para Docker**:
- Paths relativos en lugar de absolutos
- Comandos de testing adaptados
- Networking considerations

### 3. Monorepo con Multiple Stacks
**Problema**: Monorepo con varios proyectos de diferentes stacks

```bash
# Estructura típica
monorepo/
├── apps/
│   ├── web/          # Next.js
│   ├── api/          # Laravel  
│   └── mobile/       # React Native (fuera de scope)
└── packages/
    ├── ui/           # Shared React components
    └── utils/        # Shared utilities

# Detección de monorepo
if [ -f "package.json" ] && grep -q "workspaces\|lerna" package.json; then
    export AGENTIC_MONOREPO="true"
    
    # Detectar workspace actual
    if [[ "$PWD" == */apps/* ]]; then
        export AGENTIC_WORKSPACE=$(basename "$PWD")
        log "Monorepo workspace: $AGENTIC_WORKSPACE"
    fi
fi
```

## Testing Edge Cases

### 1. Laravel con Pest + PHPUnit Coexisting
**Problema**: Proyecto tiene tanto Pest como PHPUnit

```bash
# Detección de múltiples frameworks de testing
has_phpunit=false
has_pest=false

if [ -f "vendor/bin/phpunit" ]; then has_phpunit=true; fi
if [ -f "vendor/bin/pest" ]; then has_pest=true; fi

if $has_phpunit && $has_pest; then
    warn "Both PHPUnit and Pest detected"
    # Priorizar Pest si está disponible
    export AGENTIC_TEST_RUNNER="pest"
else
    export AGENTIC_TEST_RUNNER=$([ "$has_pest" = true ] && echo "pest" || echo "phpunit")
fi
```

### 2. JavaScript Testing sin package.json Scripts
**Problema**: Tests configurados pero sin script en package.json

```bash
# Detección de testing sin scripts
if [ ! -f "package.json" ] || ! grep -q "\"test\":" package.json; then
    # Buscar configuraciones de testing directas
    if [ -f "jest.config.js" ] || [ -f "vitest.config.js" ]; then
        warn "Testing configuration found but no npm test script"
        
        if [ -f "jest.config.js" ]; then
            export AGENTIC_TEST_DIRECT="npx jest"
        elif [ -f "vitest.config.js" ]; then
            export AGENTIC_TEST_DIRECT="npx vitest run"
        fi
    fi
fi
```

### 3. Python Testing Multiple Frameworks
**Problema**: Proyecto con pytest, unittest, y Django tests

```bash
# Priorizar frameworks de testing
if [ -f "manage.py" ]; then
    export AGENTIC_TEST_PRIMARY="django"
    export AGENTIC_TEST_COMMAND="python manage.py test"
elif command -v pytest >/dev/null 2>&1 && [ -f "pytest.ini" -o -f "pyproject.toml" ]; then
    export AGENTIC_TEST_PRIMARY="pytest"
    export AGENTIC_TEST_COMMAND="pytest"
else
    export AGENTIC_TEST_PRIMARY="unittest"
    export AGENTIC_TEST_COMMAND="python -m unittest discover"
fi
```

## Deployment Edge Cases

### 1. Laravel en Shared Hosting
**Problema**: Laravel deployment sin CLI access

```bash
# Detección de shared hosting constraints
if [ -f ".cpanel.yml" ] || [ -f "public_html" ]; then
    export AGENTIC_SHARED_HOSTING="true"
    warn "Shared hosting detected - Limited deployment options"
    
    # Sugerir alternativas
    log "Consider: Laravel Forge, CloudWays, or VPS for better Laravel support"
fi
```

### 2. Next.js Static Export vs Server
**Problema**: Next.js project que necesita decidir entre static y server

```bash
# Analizar características que requieren server
needs_server=false

if grep -r "getServerSideProps\|getInitialProps" pages/ app/ 2>/dev/null; then
    needs_server=true
    log "Server-side features detected"
fi

if [ -d "pages/api" ] || [ -d "app/api" ]; then
    needs_server=true
    log "API routes detected"
fi

if $needs_server; then
    export AGENTIC_NEXTJS_MODE="server"
else
    export AGENTIC_NEXTJS_MODE="static"
    log "Static export possible"
fi
```

## Performance Edge Cases

### 1. Laravel N+1 Query Detection
**Problema**: Detectar posibles N+1 queries en desarrollo

```bash
# Hook para detectar N+1 en logs de desarrollo
if [ "$AGENTIC_STACK" = "laravel" ] && [ -f "storage/logs/laravel.log" ]; then
    # Buscar patrones de N+1
    n_plus_one_count=$(grep -c "select \* from.*where.*in" storage/logs/laravel.log 2>/dev/null || echo "0")
    
    if [ "$n_plus_one_count" -gt 10 ]; then
        warn "Potential N+1 queries detected in logs ($n_plus_one_count instances)"
        warn "Consider using eager loading with ->with()"
    fi
fi
```

### 2. Next.js Bundle Size Monitoring
**Problema**: Bundle size creciendo sin control

```bash
# Verificar bundle size después de builds
if [ "$AGENTIC_STACK" = "nextjs" ] && [ -d ".next" ]; then
    # Analizar bundle size si @next/bundle-analyzer está disponible
    if grep -q "@next/bundle-analyzer" package.json; then
        log "Bundle analyzer available - Run 'npm run analyze' to check bundle size"
    fi
    
    # Warning si First Load JS es muy grande
    if [ -f ".next/static/chunks/pages/_app.js" ]; then
        app_size=$(stat -f%z ".next/static/chunks/pages/_app.js" 2>/dev/null || stat -c%s ".next/static/chunks/pages/_app.js" 2>/dev/null || echo "0")
        if [ "$app_size" -gt 500000 ]; then  # 500KB
            warn "Large app bundle detected (${app_size} bytes)"
            warn "Consider code splitting and dynamic imports"
        fi
    fi
fi
```

## Security Edge Cases

### 1. Accidental Secrets Commit
**Problema**: .env files o secrets en staging area

```bash
# Pre-commit hook para detectar secrets
if [[ "$CLAUDE_TOOL_NAME" == *"commit"* ]]; then
    # Buscar patterns de secrets en archivos staged
    if git rev-parse --git-dir >/dev/null 2>&1; then
        secrets_found=false
        
        # Patrones comunes de secrets
        if git diff --cached --name-only | grep -q "\.env$\|secrets\|\.key$"; then
            secrets_found=true
        fi
        
        # Buscar API keys, passwords, etc. en diff
        if git diff --cached | grep -i "api[_-]key\|password\|secret\|token" | grep -v "# Example\|TODO\|PLACEHOLDER"; then
            secrets_found=true
        fi
        
        if $secrets_found; then
            error "Potential secrets detected in commit"
            error "Review staged changes and remove sensitive data"
            exit 1
        fi
    fi
fi
```

## Recovery Procedures

### 1. Hook Failure Recovery
**Problema**: Hook falla y bloquea desarrollo

```bash
# Script de recovery: .seed/automation/disable-hooks.sh
#!/bin/bash
echo "Disabling agentic hooks temporarily..."

# Backup actual settings
cp .claude-settings.json .claude-settings.json.backup

# Create minimal settings
cat > .claude-settings.json << EOF
{
  "preferences": {
    "defaultLanguage": "español"
  }
}
EOF

echo "Hooks disabled. Restore with: mv .claude-settings.json.backup .claude-settings.json"
```

### 2. Output Corruption Recovery
**Problema**: Archivos .output corruptos o inconsistentes

```bash
# Script de cleanup: .seed/automation/clean-outputs.sh
#!/bin/bash
echo "Cleaning corrupted outputs..."

# Backup outputs
if [ -d ".output" ]; then
    mv .output .output.backup.$(date +%Y%m%d_%H%M%S)
fi

# Recreate clean structure
mkdir -p .output/{current,archive}
touch .output/current/.gitkeep .output/archive/.gitkeep

echo "Outputs cleaned. Previous outputs backed up."
```

---

*Edge cases documentation for Agentic Seed System*
*Focus: Laravel, Next.js, React, Python stacks*
*Updated: $(date)*