#!/bin/bash
# Hook para ejecutar después de cambios de código

set -e

# Cargar configuración de stack
if [ -f ".agentic-stack.env" ]; then
    source .agentic-stack.env
fi

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Solo ejecutar para cambios de código
if [[ "$CLAUDE_TOOL_NAME" == "Write" || "$CLAUDE_TOOL_NAME" == "MultiEdit" ]]; then
    
    # Verificar si es archivo de código
    if [[ "$CLAUDE_TOOL_PATH" == *.js || "$CLAUDE_TOOL_PATH" == *.jsx || "$CLAUDE_TOOL_PATH" == *.ts || "$CLAUDE_TOOL_PATH" == *.tsx || "$CLAUDE_TOOL_PATH" == *.php || "$CLAUDE_TOOL_PATH" == *.py || "$CLAUDE_TOOL_PATH" == *.vue ]]; then
        
        echo -e "${BLUE}🧪 Running post-code validations for $CLAUDE_TOOL_PATH${NC}"
        
        # Ejecutar tests basados en stack detectado
        run_stack_tests
        
        # Ejecutar linting si está disponible
        run_linting
        
        # Verificar sintaxis básica
        check_syntax "$CLAUDE_TOOL_PATH"
        
    fi
fi

# Función para ejecutar tests específicos del stack
run_stack_tests() {
    local test_ran=false
    
    case "$AGENTIC_STACK" in
        "laravel")
            run_laravel_tests
            test_ran=true
            ;;
        "nextjs"|"react-"*)
            run_javascript_tests
            test_ran=true
            ;;
        "django"|"flask"|"fastapi")
            run_python_tests  
            test_ran=true
            ;;
    esac
    
    if [ "$test_ran" = false ]; then
        echo -e "${YELLOW}🔍 No stack-specific tests configured${NC}"
    fi
}

# Tests para Laravel
run_laravel_tests() {
    echo -e "${BLUE}🐘 Running Laravel validations...${NC}"
    
    # PHPUnit tests
    if [ -f "vendor/bin/phpunit" ]; then
        echo -e "${BLUE}   Running PHPUnit tests...${NC}"
        if ./vendor/bin/phpunit --stop-on-failure --no-coverage --quiet; then
            echo -e "${GREEN}   ✅ PHPUnit tests passed${NC}"
        else
            echo -e "${RED}   ❌ PHPUnit tests failed${NC}"
        fi
    fi
    
    # Pest tests (alternative to PHPUnit)
    if [ -f "vendor/bin/pest" ]; then
        echo -e "${BLUE}   Running Pest tests...${NC}"  
        if ./vendor/bin/pest --stop-on-failure --compact; then
            echo -e "${GREEN}   ✅ Pest tests passed${NC}"
        else
            echo -e "${RED}   ❌ Pest tests failed${NC}"
        fi
    fi
    
    # Laravel Pint (code style)
    if [ -f "vendor/bin/pint" ]; then
        echo -e "${BLUE}   Running Laravel Pint...${NC}"
        if ./vendor/bin/pint --test; then
            echo -e "${GREEN}   ✅ Code style OK${NC}"
        else
            echo -e "${YELLOW}   ⚠️ Code style issues detected${NC}"
        fi
    fi
    
    # PHP syntax check
    if command -v php >/dev/null 2>&1; then
        if [[ "$CLAUDE_TOOL_PATH" == *.php ]]; then
            if php -l "$CLAUDE_TOOL_PATH" >/dev/null 2>&1; then
                echo -e "${GREEN}   ✅ PHP syntax OK${NC}"
            else
                echo -e "${RED}   ❌ PHP syntax error in $CLAUDE_TOOL_PATH${NC}"
            fi
        fi
    fi
}

# Tests para JavaScript/TypeScript
run_javascript_tests() {
    echo -e "${BLUE}⚡ Running JavaScript/TypeScript validations...${NC}"
    
    # npm/yarn tests
    if [ -f "package.json" ] && grep -q "\"test\":" package.json; then
        echo -e "${BLUE}   Running test suite...${NC}"
        
        # Determinar package manager
        if [ -f "yarn.lock" ]; then
            if yarn test --passWithNoTests --silent --watchAll=false; then
                echo -e "${GREEN}   ✅ Tests passed${NC}"
            else
                echo -e "${RED}   ❌ Tests failed${NC}"
            fi
        elif [ -f "package-lock.json" ] || [ -f "npm-shrinkwrap.json" ]; then
            if npm test -- --passWithNoTests --silent --watchAll=false; then
                echo -e "${GREEN}   ✅ Tests passed${NC}"
            else
                echo -e "${RED}   ❌ Tests failed${NC}"
            fi
        fi
    fi
    
    # TypeScript type checking
    if [ "$AGENTIC_TYPESCRIPT" = "true" ] && command -v npx >/dev/null 2>&1; then
        echo -e "${BLUE}   Running TypeScript type check...${NC}"
        if npx tsc --noEmit --skipLibCheck; then
            echo -e "${GREEN}   ✅ TypeScript types OK${NC}"
        else
            echo -e "${RED}   ❌ TypeScript type errors${NC}"
        fi
    fi
    
    # Next.js build check (si es Next.js)
    if [ "$AGENTIC_STACK" = "nextjs" ] && [ -f "next.config.js" -o -f "next.config.mjs" ]; then
        echo -e "${BLUE}   Checking Next.js build...${NC}"
        if npx next build --dry-run >/dev/null 2>&1; then
            echo -e "${GREEN}   ✅ Next.js build OK${NC}"
        else
            echo -e "${YELLOW}   ⚠️ Next.js build issues detected${NC}"
        fi
    fi
}

# Tests para Python
run_python_tests() {
    echo -e "${BLUE}🐍 Running Python validations...${NC}"
    
    case "$AGENTIC_STACK" in
        "django")
            # Django tests
            if [ -f "manage.py" ]; then
                echo -e "${BLUE}   Running Django tests...${NC}"
                if python manage.py test --verbosity=0 --keepdb 2>/dev/null; then
                    echo -e "${GREEN}   ✅ Django tests passed${NC}"
                else
                    echo -e "${RED}   ❌ Django tests failed${NC}"
                fi
                
                # Django check
                if python manage.py check --quiet; then
                    echo -e "${GREEN}   ✅ Django system check OK${NC}"
                else
                    echo -e "${RED}   ❌ Django system check failed${NC}"
                fi
            fi
            ;;
        "flask"|"fastapi")
            # Pytest tests
            if command -v pytest >/dev/null 2>&1; then
                echo -e "${BLUE}   Running pytest...${NC}"
                if pytest -q --tb=no; then
                    echo -e "${GREEN}   ✅ Pytest passed${NC}"
                else
                    echo -e "${RED}   ❌ Pytest failed${NC}"
                fi
            fi
            ;;
    esac
    
    # Python syntax check
    if command -v python >/dev/null 2>&1; then
        if [[ "$CLAUDE_TOOL_PATH" == *.py ]]; then
            if python -m py_compile "$CLAUDE_TOOL_PATH" 2>/dev/null; then
                echo -e "${GREEN}   ✅ Python syntax OK${NC}"
            else
                echo -e "${RED}   ❌ Python syntax error in $CLAUDE_TOOL_PATH${NC}"
            fi
        fi
    fi
}

# Ejecutar linting
run_linting() {
    local linting_ran=false
    
    # JavaScript/TypeScript linting
    if [ -f "package.json" ] && grep -q "\"lint\":" package.json; then
        echo -e "${BLUE}🔍 Running ESLint...${NC}"
        
        if [ -f "yarn.lock" ]; then
            if yarn lint --quiet; then
                echo -e "${GREEN}   ✅ Linting OK${NC}"
            else
                echo -e "${YELLOW}   ⚠️ Linting issues detected${NC}"
            fi
        else
            if npm run lint -- --quiet; then
                echo -e "${GREEN}   ✅ Linting OK${NC}"
            else
                echo -e "${YELLOW}   ⚠️ Linting issues detected${NC}"
            fi
        fi
        linting_ran=true
    fi
    
    # Python linting
    if [[ "$AGENTIC_STACK" == "django" || "$AGENTIC_STACK" == "flask" || "$AGENTIC_STACK" == "fastapi" ]]; then
        # Flake8 
        if command -v flake8 >/dev/null 2>&1; then
            echo -e "${BLUE}🔍 Running flake8...${NC}"
            if flake8 "$CLAUDE_TOOL_PATH" --quiet 2>/dev/null; then
                echo -e "${GREEN}   ✅ Flake8 OK${NC}"
            else
                echo -e "${YELLOW}   ⚠️ Flake8 issues detected${NC}"
            fi
            linting_ran=true
        fi
        
        # Black formatting check
        if command -v black >/dev/null 2>&1; then
            echo -e "${BLUE}🔍 Checking Black formatting...${NC}"
            if black --check "$CLAUDE_TOOL_PATH" --quiet 2>/dev/null; then
                echo -e "${GREEN}   ✅ Black formatting OK${NC}"
            else
                echo -e "${YELLOW}   ⚠️ Black formatting needed${NC}"
            fi
            linting_ran=true
        fi
    fi
    
    if [ "$linting_ran" = false ]; then
        echo -e "${YELLOW}🔍 No linting tools configured${NC}"
    fi
}

# Verificar sintaxis básica
check_syntax() {
    local file_path="$1"
    
    case "$file_path" in
        *.json)
            if command -v python >/dev/null 2>&1; then
                if python -m json.tool "$file_path" >/dev/null 2>&1; then
                    echo -e "${GREEN}✅ JSON syntax OK${NC}"
                else
                    echo -e "${RED}❌ JSON syntax error${NC}"
                fi
            fi
            ;;
        *.yaml|*.yml)
            if command -v python >/dev/null 2>&1; then
                if python -c "import yaml; yaml.safe_load(open('$file_path'))" 2>/dev/null; then
                    echo -e "${GREEN}✅ YAML syntax OK${NC}"
                else
                    echo -e "${RED}❌ YAML syntax error${NC}"
                fi
            fi
            ;;
    esac
}

echo -e "${GREEN}✅ Post-code validations completed${NC}"