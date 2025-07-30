# Hook Variables Reference

Documentación completa de variables disponibles en hooks y scripts de automatización.

## Variables de Claude Code

### Session Hooks
Variables disponibles en `SessionStart` hooks:

```bash
$CLAUDE_SESSION_ID          # ID único de la sesión actual
$CLAUDE_PROJECT_PATH        # Ruta absoluta del proyecto
$CLAUDE_USER_ID             # ID del usuario (si disponible)
$CLAUDE_MODEL               # Modelo de Claude usado (sonnet, opus, etc.)
```

### Tool Hooks
Variables disponibles en `PreToolUse` y `PostToolUse`:

```bash
$CLAUDE_TOOL_NAME           # Nombre del tool (Write, MultiEdit, Read, etc.)
$CLAUDE_TOOL_PATH           # Archivo siendo modificado/leído
$CLAUDE_TOOL_CONTENT        # Contenido del cambio (solo PostToolUse)
$CLAUDE_TOOL_OLD_CONTENT    # Contenido anterior (solo PostToolUse con MultiEdit)
$CLAUDE_TOOL_ARGS           # Argumentos del tool (JSON format)
```

### User Prompt Hooks
Variables disponibles en `UserPromptSubmit`:

```bash
$CLAUDE_PROMPT_TEXT         # Texto del prompt del usuario
$CLAUDE_PROMPT_LENGTH       # Longitud del prompt
$CLAUDE_CONVERSATION_TURN   # Número de turno en la conversación
```

## Variables del Sistema Agentic

### Stack Detection
Variables generadas por `stack-detector.sh`:

```bash
# Variables principales
$AGENTIC_STACK              # Stack detectado (laravel, nextjs, react-cra, etc.)
$AGENTIC_PATTERN            # Patrón de proyecto (single, fullstack)
$AGENTIC_FRAMEWORK_VERSION  # Versión del framework principal
$AGENTIC_TYPESCRIPT         # true/false - Proyecto usa TypeScript
$AGENTIC_PHASE              # Fase actual (analysis, development, production)

# Variables por stack
$AGENTIC_API_MODE           # Laravel: true si tiene rutas API
$AGENTIC_LIVEWIRE           # Laravel: true si usa Livewire
$AGENTIC_INERTIA            # Laravel: true si usa Inertia.js
$AGENTIC_APP_ROUTER         # Next.js: true si usa App Router
$AGENTIC_PAGES_ROUTER       # Next.js: true si usa Pages Router
$AGENTIC_API_ROUTES         # Next.js: true si tiene API routes
$AGENTIC_BUILD_TOOL         # React: cra, vite, custom
$AGENTIC_REACT_TYPE         # React: react-cra, react-vite, react-custom
$AGENTIC_DRF                # Django: true si usa Django REST Framework
$AGENTIC_ASYNC              # Python: true si usa async/await
$AGENTIC_FULLSTACK          # true si es proyecto fullstack
```

### Output Management
Variables para gestión de outputs:

```bash
$AGENTIC_OUTPUT_DIR         # Directorio de outputs (.output/)
$AGENTIC_CURRENT_DIR        # Directorio de versiones actuales (.output/current/)
$AGENTIC_ARCHIVE_DIR        # Directorio de archivo (.output/archive/)
$AGENTIC_VERSION_POLICY     # Política de versionado (auto, manual)
```

## Uso en Scripts

### Ejemplo: Hook Condicional por Stack
```bash
#!/bin/bash
# Hook que actúa diferente según el stack

if [ -f ".agentic-stack.env" ]; then
    source .agentic-stack.env
fi

case "$AGENTIC_STACK" in
    "laravel")
        echo "🐘 Laravel-specific actions"
        if [ "$AGENTIC_API_MODE" = "true" ]; then
            echo "API mode detected"
        fi
        ;;
    "nextjs")
        echo "⚡ Next.js-specific actions"
        if [ "$AGENTIC_APP_ROUTER" = "true" ]; then
            echo "Using App Router"
        fi
        ;;
    *)
        echo "Generic actions"
        ;;
esac
```

### Ejemplo: Validación Basada en Herramientas
```bash
#!/bin/bash
# Validación específica por tool

case "$CLAUDE_TOOL_NAME" in
    "Write")
        echo "Single file write: $CLAUDE_TOOL_PATH"
        ;;
    "MultiEdit")
        echo "Multiple edits in: $CLAUDE_TOOL_PATH"
        ;;
    "Read")
        echo "File read: $CLAUDE_TOOL_PATH"
        # No ejecutar validaciones para lecturas
        exit 0
        ;;
esac
```

## Variables de Configuración

### Archivos de Configuración
Variables leídas desde archivos:

```bash
# .agentic-stack.env (generado automáticamente)
AGENTIC_STACK=laravel
AGENTIC_PATTERN=fullstack
AGENTIC_FRAMEWORK_VERSION=10.0
AGENTIC_TYPESCRIPT=false
AGENTIC_API_MODE=true

# .env (proyecto específico)
APP_ENV=development
DATABASE_URL=postgresql://...
API_KEY=sk-...
```

### Variables de Entorno del Sistema
```bash
# Paths importantes
$HOME                       # Directorio home del usuario
$PWD                        # Directorio actual
$PATH                       # PATH del sistema

# Variables de desarrollo
$NODE_ENV                   # development, production, test
$APP_ENV                    # Entorno de la aplicación
$DEBUG                      # Modo debug activado
```

## Debugging de Variables

### Script de Debug
```bash
#!/bin/bash
# .seed/automation/debug-vars.sh

echo "=== Claude Code Variables ==="
env | grep "^CLAUDE_" | sort

echo -e "\n=== Agentic Variables ==="
env | grep "^AGENTIC_" | sort

echo -e "\n=== Stack Configuration ==="
if [ -f ".agentic-stack.env" ]; then
    cat .agentic-stack.env
else
    echo "No stack configuration found"
fi

echo -e "\n=== Project Files ==="
echo "package.json: $([ -f package.json ] && echo '✅' || echo '❌')"
echo "composer.json: $([ -f composer.json ] && echo '✅' || echo '❌')"
echo "requirements.txt: $([ -f requirements.txt ] && echo '✅' || echo '❌')"
echo "PRD.md: $([ -f PRD.md ] && echo '✅' || echo '❌')"
```

### Logging de Variables en Hooks
```bash
#!/bin/bash
# Logging template para hooks

# Crear log file si no existe
LOG_FILE=".agentic-hooks.log"
touch "$LOG_FILE"

# Function para logging con timestamp
log_with_timestamp() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Log de variables importantes
log_with_timestamp "Hook: $(basename "$0")"
log_with_timestamp "Tool: $CLAUDE_TOOL_NAME"
log_with_timestamp "Path: $CLAUDE_TOOL_PATH" 
log_with_timestamp "Stack: $AGENTIC_STACK"
```

## Mejores Prácticas

### 1. Verificación de Variables
```bash
# Siempre verificar si la variable existe
if [ -n "$CLAUDE_TOOL_PATH" ]; then
    # Variable existe y no está vacía
    echo "Processing: $CLAUDE_TOOL_PATH"
else
    echo "No tool path available"
    exit 0
fi
```

### 2. Valores por Defecto
```bash
# Usar valores por defecto
STACK=${AGENTIC_STACK:-"unknown"}
TYPESCRIPT=${AGENTIC_TYPESCRIPT:-"false"}
```

### 3. Validación de Configuración
```bash
# Validar configuración crítica
if [ ! -f ".agentic-stack.env" ]; then
    echo "Warning: No stack configuration found"
    echo "Run stack-detector.sh to generate configuration"
fi
```

### 4. Manejo de Errores
```bash
# Manejo robusto de errores
set -e  # Exit on error
set -u  # Exit on undefined variable

# Trap para cleanup
trap 'echo "Hook failed at line $LINENO"' ERR
```

## Extensión del Sistema

### Agregar Nuevas Variables
Para agregar nuevas variables al sistema:

1. **Modificar `stack-detector.sh`**:
```bash
# Agregar detección de nueva característica
if grep -q "nueva-libreria" package.json; then
    export AGENTIC_NUEVA_FEATURE="true"
    log "Nueva feature detectada"
fi
```

2. **Actualizar `.agentic-stack.env`**:
```bash
# Agregar al archivo de configuración
echo "AGENTIC_NUEVA_FEATURE=${AGENTIC_NUEVA_FEATURE:-false}" >> .agentic-stack.env
```

3. **Documentar en esta guía**:
Agregar la nueva variable a la sección correspondiente.

### Variables Personalizadas
Para proyectos específicos, crear `.agentic-custom.env`:

```bash
# Variables específicas del proyecto
AGENTIC_CUSTOM_FEATURE=true
AGENTIC_DEPLOYMENT_STRATEGY=docker
AGENTIC_MONITORING_ENABLED=true
```

Y cargarlas en hooks:
```bash
# Cargar configuración personalizada
if [ -f ".agentic-custom.env" ]; then
    source .agentic-custom.env
fi
```

---

*Variables documentation for Agentic Seed System*
*Updated: $(date)*