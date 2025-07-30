#!/bin/bash
# Hook para validación antes de escribir código

set -e

# Cargar configuración de stack si existe
if [ -f ".agentic-stack.env" ]; then
    source .agentic-stack.env
fi

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔍 Pre-write validation...${NC}"

# Función para verificar si es archivo de código
is_code_file() {
    local file_path="$1"
    
    case "$file_path" in
        *.js|*.jsx|*.ts|*.tsx|*.php|*.py|*.vue|*.blade.php|*.html|*.css|*.scss)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Función para verificar si es archivo de configuración crítico
is_critical_config() {
    local file_path="$1"
    
    case "$file_path" in
        package.json|composer.json|requirements.txt|tsconfig.json|next.config.js|tailwind.config.js|vite.config.js|webpack.config.js|.env*|settings.py|manage.py)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Validación principal basada en tipo de archivo
if [ -n "$CLAUDE_TOOL_PATH" ]; then
    
    # Si es código, verificar que el análisis esté completo
    if is_code_file "$CLAUDE_TOOL_PATH"; then
        
        echo -e "${YELLOW}📝 Code file detected: $CLAUDE_TOOL_PATH${NC}"
        
        # Verificar que tengamos plan de desarrollo
        if [ ! -f ".output/current/dev-plan.md" ] && [ ! -f ".output/v*_dev-plan.md" ]; then
            echo -e "${RED}❌ ERROR: Attempting to write code without development plan${NC}"
            echo "Complete the analysis pipeline first:"
            echo "1. /analyze             # PRD analysis"
            echo "2. /decide-stack        # Technology decision"  
            echo "3. /design-arch         # Architecture design"
            echo "4. /plan-dev           # Development plan"
            echo ""
            echo "Only then execute /setup-project to start coding"
            exit 1
        fi
        
        # Stack-specific validations
        case "$AGENTIC_STACK" in
            "laravel")
                validate_laravel_code "$CLAUDE_TOOL_PATH"
                ;;
            "nextjs")
                validate_nextjs_code "$CLAUDE_TOOL_PATH"
                ;;
            "react-"*)
                validate_react_code "$CLAUDE_TOOL_PATH"
                ;;
            "django"|"flask"|"fastapi")
                validate_python_code "$CLAUDE_TOOL_PATH"
                ;;
        esac
        
        echo -e "${GREEN}✅ Development plan found - Proceeding with code write${NC}"
        
    # Si es configuración crítica, advertir
    elif is_critical_config "$CLAUDE_TOOL_PATH"; then
        echo -e "${YELLOW}⚠️ Modifying critical configuration: $CLAUDE_TOOL_PATH${NC}"
        echo -e "${YELLOW}   Ensure this aligns with architecture decisions${NC}"
        
    # Archivos de análisis/documentación
    elif [[ "$CLAUDE_TOOL_PATH" == *.md ]]; then
        echo -e "${BLUE}📄 Documentation file: $CLAUDE_TOOL_PATH${NC}"
        
        # Si es un output, sugerir versionado
        if [[ "$CLAUDE_TOOL_PATH" == .output/* ]]; then
            echo -e "${YELLOW}💡 Tip: Use version-output.sh to version this file${NC}"
        fi
    fi
    
else
    echo -e "${YELLOW}⚠️ No file path detected - Generic validation${NC}"
fi

# Validaciones específicas por stack

validate_laravel_code() {
    local file_path="$1"
    
    case "$file_path" in
        app/Http/Controllers/*)
            echo -e "${BLUE}🐘 Laravel Controller detected${NC}"
            ;;
        app/Models/*)
            echo -e "${BLUE}🐘 Eloquent Model detected${NC}"
            ;;
        app/Services/*)
            echo -e "${BLUE}🐘 Service Layer detected${NC}"
            ;;
        database/migrations/*)
            echo -e "${BLUE}🐘 Database Migration detected${NC}"
            ;;
        resources/views/*)
            echo -e "${BLUE}🐘 Blade Template detected${NC}"
            ;;
        routes/*)
            echo -e "${BLUE}🐘 Route Definition detected${NC}"
            ;;
    esac
}

validate_nextjs_code() {
    local file_path="$1"
    
    case "$file_path" in
        app/*/page.*)
            echo -e "${BLUE}⚡ Next.js Page (App Router) detected${NC}"
            ;;
        app/*/layout.*)
            echo -e "${BLUE}⚡ Next.js Layout (App Router) detected${NC}"
            ;;
        app/api/*)
            echo -e "${BLUE}⚡ Next.js API Route detected${NC}"
            ;;
        pages/*)
            echo -e "${BLUE}⚡ Next.js Page (Pages Router) detected${NC}"
            ;;
        pages/api/*)
            echo -e "${BLUE}⚡ Next.js API Route (Pages Router) detected${NC}"
            ;;
        components/*)
            echo -e "${BLUE}⚡ React Component detected${NC}"
            ;;
        lib/*)
            echo -e "${BLUE}⚡ Utility/Library code detected${NC}"
            ;;
    esac
    
    # TypeScript specific
    if [ "$AGENTIC_TYPESCRIPT" = "true" ] && [[ "$file_path" == *.js ]]; then
        echo -e "${YELLOW}⚠️ JavaScript file in TypeScript project - Consider using .ts/.tsx${NC}"
    fi
}

validate_react_code() {
    local file_path="$1"
    
    case "$file_path" in
        src/components/*)
            echo -e "${BLUE}⚛️ React Component detected${NC}"
            ;;
        src/hooks/*)
            echo -e "${BLUE}⚛️ Custom Hook detected${NC}"
            ;;
        src/services/*)
            echo -e "${BLUE}⚛️ Service Layer detected${NC}"
            ;;
        src/store/*|src/redux/*)
            echo -e "${BLUE}⚛️ State Management detected${NC}"
            ;;
        src/utils/*)
            echo -e "${BLUE}⚛️ Utility code detected${NC}"
            ;;
    esac
}

validate_python_code() {
    local file_path="$1"
    
    case "$AGENTIC_STACK" in
        "django")
            case "$file_path" in
                */models.py)
                    echo -e "${BLUE}🐍 Django Model detected${NC}"
                    ;;
                */views.py)
                    echo -e "${BLUE}🐍 Django View detected${NC}"
                    ;;
                */serializers.py)
                    echo -e "${BLUE}🐍 DRF Serializer detected${NC}"
                    ;;
                */urls.py)
                    echo -e "${BLUE}🐍 Django URL Config detected${NC}"
                    ;;
                */admin.py)
                    echo -e "${BLUE}🐍 Django Admin detected${NC}"
                    ;;
            esac
            ;;
        "flask"|"fastapi")
            case "$file_path" in
                app.py|main.py)
                    echo -e "${BLUE}🐍 Main Application File detected${NC}"
                    ;;
                */models.py)
                    echo -e "${BLUE}🐍 Data Models detected${NC}"
                    ;;
                */routes.py|*/endpoints.py)
                    echo -e "${BLUE}🐍 API Routes detected${NC}"
                    ;;
            esac
            ;;
    esac
}

echo -e "${GREEN}✅ Pre-write validation completed${NC}"