#!/bin/bash
# Stack detection and optimization for Laravel, Next.js, React, Python

set -e

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Logging functions
log() { echo -e "${BLUE}[STACK]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Detectar stack principal
detect_primary_stack() {
    # Laravel detection
    if [ -f "composer.json" ]; then
        if grep -q "laravel/framework" composer.json; then
            echo "laravel"
            return
        elif grep -q "symfony/symfony" composer.json; then
            echo "symfony"
            return
        else
            echo "php-general"
            return
        fi
    fi
    
    # Next.js detection
    if [ -f "package.json" ]; then
        if grep -q "\"next\":" package.json; then
            echo "nextjs"
            return
        elif grep -q "\"react\":" package.json && grep -q "\"react-dom\":" package.json; then
            # Check if it's CRA or Vite
            if grep -q "react-scripts" package.json; then
                echo "react-cra"
                return
            elif grep -q "vite" package.json; then
                echo "react-vite"
                return
            else
                echo "react-custom"
                return
            fi
        elif grep -q "\"vue\":" package.json; then
            echo "vue"
            return
        else
            echo "node-general"
            return
        fi
    fi
    
    # Python detection
    if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ] || [ -f "Pipfile" ]; then
        if [ -f "manage.py" ] || grep -q "django" requirements.txt 2>/dev/null; then
            echo "django"
            return
        elif grep -q "flask" requirements.txt 2>/dev/null || [ -f "app.py" ]; then
            echo "flask"
            return
        elif grep -q "fastapi" requirements.txt 2>/dev/null; then
            echo "fastapi"
            return
        else
            echo "python-general"
            return
        fi
    fi
    
    echo "unknown"
}

# Detectar si es fullstack
detect_fullstack_pattern() {
    local has_backend=false
    local has_frontend=false
    
    # Backend detection
    if [ -f "composer.json" ] || [ -f "requirements.txt" ] || [ -f "manage.py" ]; then
        has_backend=true
    fi
    
    # Frontend detection
    if [ -f "package.json" ]; then
        has_frontend=true
    fi
    
    if $has_backend && $has_frontend; then
        echo "fullstack"
    else
        echo "single"
    fi
}

# Optimizar para stack específico
optimize_for_stack() {
    local stack=$1
    local pattern=$2
    
    log "Optimizing for $stack ($pattern)"
    
    case $stack in
        "laravel")
            optimize_laravel $pattern
            ;;
        "nextjs")
            optimize_nextjs $pattern
            ;;
        "react-cra"|"react-vite"|"react-custom")
            optimize_react $pattern
            ;;
        "django")
            optimize_django $pattern
            ;;
        "flask"|"fastapi")
            optimize_python_api $pattern
            ;;
        *)
            warn "Unknown stack: $stack - Using generic optimizations"
            ;;
    esac
}

# Optimizaciones Laravel
optimize_laravel() {
    local pattern=$1
    
    success "🐘 Laravel optimizations active"
    
    # Set Laravel-specific environment variables
    export AGENTIC_STACK="laravel"
    export AGENTIC_FRAMEWORK_VERSION=$(grep "laravel/framework" composer.json | grep -o '"[0-9]\+\.[0-9]\+' | tr -d '"' || echo "unknown")
    
    # Check for common Laravel patterns
    if [ -f "app/Http/Controllers/Controller.php" ]; then
        log "Standard Laravel structure detected"
    fi
    
    # Check for API setup
    if [ -f "routes/api.php" ] && grep -q "api" routes/api.php; then
        export AGENTIC_API_MODE="true"
        log "Laravel API mode detected"
    fi
    
    # Check for authentication
    if [ -d "app/Http/Controllers/Auth" ] || grep -q "laravel/sanctum" composer.json; then
        log "Laravel authentication detected"
    fi
    
    # Livewire detection
    if grep -q "livewire/livewire" composer.json; then
        export AGENTIC_LIVEWIRE="true"
        log "Livewire detected - Full-stack Laravel mode"
    fi
    
    # Inertia.js detection
    if grep -q "inertiajs/inertia-laravel" composer.json; then
        export AGENTIC_INERTIA="true"
        log "Inertia.js detected - Modern Laravel SPA mode"
    fi
    
    if [ "$pattern" = "fullstack" ]; then
        log "Laravel + Frontend detected - Configuring hybrid optimizations"
        export AGENTIC_FULLSTACK="true"
    fi
}

# Optimizaciones Next.js
optimize_nextjs() {
    local pattern=$1
    
    success "⚡ Next.js optimizations active"
    
    export AGENTIC_STACK="nextjs"
    export AGENTIC_FRAMEWORK_VERSION=$(grep "\"next\":" package.json | grep -o '[0-9]\+\.[0-9]\+' || echo "unknown")
    
    # Check for App Router (Next.js 13+)
    if [ -d "app" ] && [ -f "app/layout.tsx" -o -f "app/layout.jsx" ]; then
        export AGENTIC_APP_ROUTER="true"
        log "Next.js App Router detected"
    elif [ -d "pages" ]; then
        export AGENTIC_PAGES_ROUTER="true"
        log "Next.js Pages Router detected"
    fi
    
    # Check for TypeScript
    if [ -f "tsconfig.json" ]; then
        export AGENTIC_TYPESCRIPT="true"
        log "TypeScript configuration detected"
    fi
    
    # Check for common libraries
    if grep -q "prisma" package.json; then
        log "Prisma ORM detected"
    fi
    
    if grep -q "next-auth" package.json; then
        log "NextAuth.js authentication detected"
    fi
    
    if grep -q "tailwindcss" package.json; then
        log "Tailwind CSS detected"
    fi
    
    # API routes detection
    if [ -d "app/api" ] || [ -d "pages/api" ]; then
        export AGENTIC_API_ROUTES="true"
        log "Next.js API routes detected"
    fi
}

# Optimizaciones React
optimize_react() {
    local pattern=$1
    local react_type=$1
    
    success "⚛️ React optimizations active ($react_type)"
    
    export AGENTIC_STACK="react"
    export AGENTIC_REACT_TYPE="$react_type"
    
    # Framework-specific optimizations
    case $react_type in
        "react-cra")
            export AGENTIC_BUILD_TOOL="cra"
            log "Create React App detected"
            ;;
        "react-vite")
            export AGENTIC_BUILD_TOOL="vite"
            log "Vite build tool detected"
            ;;
        "react-custom")
            export AGENTIC_BUILD_TOOL="custom"
            log "Custom React setup detected"
            ;;
    esac
    
    # Check for TypeScript
    if [ -f "tsconfig.json" ]; then
        export AGENTIC_TYPESCRIPT="true"
        log "TypeScript configuration detected"
    fi
    
    # State management detection
    if grep -q "@reduxjs/toolkit\|redux" package.json; then
        log "Redux state management detected"
    elif grep -q "zustand" package.json; then
        log "Zustand state management detected"
    elif grep -q "jotai" package.json; then
        log "Jotai state management detected"
    fi
    
    # Router detection
    if grep -q "react-router" package.json; then
        log "React Router detected"
    fi
    
    # UI library detection
    if grep -q "@mui/material\|@material-ui" package.json; then
        log "Material-UI detected"
    elif grep -q "antd" package.json; then
        log "Ant Design detected"
    elif grep -q "@chakra-ui" package.json; then
        log "Chakra UI detected"
    fi
}

# Optimizaciones Django
optimize_django() {
    local pattern=$1
    
    success "🐍 Django optimizations active"
    
    export AGENTIC_STACK="django"
    export AGENTIC_FRAMEWORK_VERSION=$(python -c "import django; print(django.VERSION[:2])" 2>/dev/null | tr -d "()," || echo "unknown")
    
    # Check for Django REST Framework
    if grep -q "djangorestframework" requirements.txt 2>/dev/null; then
        export AGENTIC_DRF="true"
        log "Django REST Framework API detected"
    fi
    
    # Check for async support
    if grep -q "asgiref\|channels" requirements.txt 2>/dev/null; then
        export AGENTIC_ASYNC="true"
        log "Django async support detected"
    fi
    
    # Check for Celery
    if grep -q "celery" requirements.txt 2>/dev/null; then
        log "Celery background tasks detected"
    fi
    
    if [ "$pattern" = "fullstack" ]; then
        log "Django + Frontend detected"
        export AGENTIC_FULLSTACK="true"
    fi
}

# Optimizaciones Python API
optimize_python_api() {
    local framework=$1
    
    success "🐍 Python API optimizations active ($framework)"
    
    export AGENTIC_STACK="$framework"
    
    case $framework in
        "flask")
            log "Flask API framework detected"
            if grep -q "flask-restful\|flask-api" requirements.txt 2>/dev/null; then
                log "Flask REST extensions detected"
            fi
            ;;
        "fastapi")
            log "FastAPI framework detected"
            export AGENTIC_ASYNC="true"
            if grep -q "sqlalchemy" requirements.txt 2>/dev/null; then
                log "SQLAlchemy ORM detected"
            fi
            ;;
    esac
}

# Crear archivo de configuración para hooks
create_stack_config() {
    local stack=$1
    local pattern=$2
    
    local config_file=".agentic-stack.env"
    
    cat > "$config_file" << EOF
# Agentic Stack Configuration
# Generated on $(date)

AGENTIC_STACK=$stack
AGENTIC_PATTERN=$pattern
AGENTIC_FRAMEWORK_VERSION=${AGENTIC_FRAMEWORK_VERSION:-unknown}
AGENTIC_TYPESCRIPT=${AGENTIC_TYPESCRIPT:-false}
AGENTIC_API_MODE=${AGENTIC_API_MODE:-false}
AGENTIC_FULLSTACK=${AGENTIC_FULLSTACK:-false}

# Stack-specific variables
$(env | grep "^AGENTIC_" || true)
EOF
    
    success "Stack configuration saved to $config_file"
}

# Función principal
main() {
    log "Detecting project stack..."
    
    local stack=$(detect_primary_stack)
    local pattern=$(detect_fullstack_pattern)
    
    if [ "$stack" = "unknown" ]; then
        warn "Could not detect stack - using generic configuration"
        return 1
    fi
    
    log "Detected: $stack ($pattern pattern)"
    
    # Optimizar para el stack detectado
    optimize_for_stack "$stack" "$pattern"
    
    # Crear configuración
    create_stack_config "$stack" "$pattern"
    
    success "Stack optimization completed for $stack"
    
    return 0
}

# Ejecutar si es llamado directamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi