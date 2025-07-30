#!/bin/bash
# Hook para verificaciones antes de commits

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

echo -e "${BLUE}🔍 Pre-commit validations running...${NC}"

# Función para verificar secretos
check_secrets() {
    local secrets_found=false
    
    # Verificar archivos .env en staging
    if git diff --cached --name-only 2>/dev/null | grep -q "\.env$\|\.key$\|secrets"; then
        echo -e "${RED}⚠️ Environment/secret files detected in commit${NC}"
        secrets_found=true
    fi
    
    # Buscar patrones de API keys, passwords, etc.
    if git diff --cached 2>/dev/null | grep -i "api[_-]key.*=\|password.*=\|secret.*=\|token.*=" | grep -v "EXAMPLE\|TODO\|PLACEHOLDER\|your-api-key-here"; then
        echo -e "${RED}⚠️ Potential secrets detected in commit content${NC}"
        secrets_found=true
    fi
    
    if $secrets_found; then
        echo -e "${RED}❌ Security check failed - Potential secrets in commit${NC}"
        return 1
    fi
    
    return 0
}

# Función para ejecutar linting
run_linting() {
    local lint_failed=false
    
    case "$AGENTIC_STACK" in
        "laravel")
            # PHP CS Fixer o Laravel Pint
            if [ -f "vendor/bin/pint" ]; then
                echo -e "${BLUE}🔧 Running Laravel Pint...${NC}"
                if ! ./vendor/bin/pint --test; then
                    echo -e "${RED}❌ Laravel Pint failed${NC}"
                    lint_failed=true
                fi
            elif [ -f ".php-cs-fixer.php" ] && command -v php-cs-fixer >/dev/null 2>&1; then
                echo -e "${BLUE}🔧 Running PHP CS Fixer...${NC}"
                if ! php-cs-fixer fix --dry-run --diff; then
                    echo -e "${RED}❌ PHP CS Fixer failed${NC}"
                    lint_failed=true
                fi
            fi
            ;;
            
        "nextjs"|"react-"*)
            # ESLint para JavaScript/TypeScript
            if [ -f "package.json" ] && grep -q "\"lint\":" package.json; then
                echo -e "${BLUE}🔧 Running ESLint...${NC}"
                
                if [ -f "yarn.lock" ]; then
                    if ! yarn lint; then
                        lint_failed=true
                    fi
                elif [ -f "package-lock.json" ]; then
                    if ! npm run lint; then
                        lint_failed=true
                    fi
                fi
                
                if $lint_failed; then
                    echo -e "${RED}❌ ESLint failed${NC}"
                fi
            fi
            ;;
            
        "django"|"flask"|"fastapi")
            # Python linting
            if command -v flake8 >/dev/null 2>&1; then
                echo -e "${BLUE}🔧 Running flake8...${NC}"
                if ! flake8 --max-line-length=88 --extend-ignore=E203; then
                    echo -e "${RED}❌ Flake8 failed${NC}"
                    lint_failed=true
                fi
            fi
            
            # Black formatting check
            if command -v black >/dev/null 2>&1; then
                echo -e "${BLUE}🔧 Checking Black formatting...${NC}"
                if ! black --check --diff .; then
                    echo -e "${RED}❌ Black formatting needed${NC}"
                    lint_failed=true
                fi
            fi
            ;;
    esac
    
    return $([ "$lint_failed" = true ] && echo 1 || echo 0)
}

# Función para ejecutar tests
run_tests() {
    local test_failed=false
    
    case "$AGENTIC_STACK" in
        "laravel")
            if [ -f "vendor/bin/pest" ]; then
                echo -e "${BLUE}🧪 Running Pest tests...${NC}"
                if ! ./vendor/bin/pest --compact --stop-on-failure; then
                    test_failed=true
                fi
            elif [ -f "vendor/bin/phpunit" ]; then
                echo -e "${BLUE}🧪 Running PHPUnit tests...${NC}"
                if ! ./vendor/bin/phpunit --stop-on-failure; then
                    test_failed=true
                fi
            fi
            ;;
            
        "nextjs"|"react-"*)
            if [ -f "package.json" ] && grep -q "\"test\":" package.json; then
                echo -e "${BLUE}🧪 Running JavaScript tests...${NC}"
                
                if [ -f "yarn.lock" ]; then
                    if ! yarn test --watchAll=false --passWithNoTests; then
                        test_failed=true
                    fi
                elif [ -f "package-lock.json" ]; then
                    if ! npm test -- --watchAll=false --passWithNoTests; then
                        test_failed=true
                    fi
                fi
            fi
            ;;
            
        "django")
            if [ -f "manage.py" ]; then
                echo -e "${BLUE}🧪 Running Django tests...${NC}"
                if ! python manage.py test --keepdb --verbosity=1; then
                    test_failed=true
                fi
            fi
            ;;
            
        "flask"|"fastapi")
            if command -v pytest >/dev/null 2>&1; then
                echo -e "${BLUE}🧪 Running pytest...${NC}"
                if ! pytest -q; then
                    test_failed=true
                fi
            fi
            ;;
    esac
    
    if $test_failed; then
        echo -e "${RED}❌ Tests failed${NC}"
        return 1
    fi
    
    return 0
}

# Buscar TODOs y FIXMEs
check_todos() {
    echo -e "${BLUE}🔍 Checking for TODOs and FIXMEs...${NC}"
    
    local extensions="js ts jsx tsx php py vue"
    local todo_found=false
    
    for ext in $extensions; do
        if find . -name "*.${ext}" -not -path "./node_modules/*" -not -path "./vendor/*" -not -path "./.git/*" -exec grep -l "TODO\|FIXME" {} \; 2>/dev/null | head -5; then
            todo_found=true
        fi
    done
    
    if $todo_found; then
        echo -e "${YELLOW}⚠️ TODOs or FIXMEs found in code${NC}"
        echo -e "${YELLOW}   Consider resolving before commit${NC}"
    fi
}

# Verificar archivos grandes
check_file_sizes() {
    echo -e "${BLUE}📁 Checking file sizes...${NC}"
    
    # Buscar archivos mayores a 1MB que no sean de node_modules, vendor, etc.
    large_files=$(find . -type f -size +1M -not -path "./node_modules/*" -not -path "./vendor/*" -not -path "./.git/*" -not -path "./storage/*" 2>/dev/null || true)
    
    if [ -n "$large_files" ]; then
        echo -e "${YELLOW}⚠️ Large files detected:${NC}"
        echo "$large_files" | while read -r file; do
            size=$(ls -lh "$file" | awk '{print $5}')
            echo -e "${YELLOW}   $file ($size)${NC}"
        done
        echo -e "${YELLOW}   Consider using Git LFS for large files${NC}"
    fi
}

# Main execution
main() {
    # Solo ejecutar si estamos en un repo git
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        echo -e "${YELLOW}⚠️ Not a git repository - Skipping git-specific checks${NC}"
        return 0
    fi
    
    # Verificar si hay cambios staged
    if ! git diff --cached --quiet 2>/dev/null; then
        echo -e "${BLUE}📝 Changes detected in staging area${NC}"
    else
        echo -e "${YELLOW}⚠️ No staged changes detected${NC}"
        return 0
    fi
    
    local checks_failed=false
    
    # 1. Verificar secretos (crítico)
    if ! check_secrets; then
        checks_failed=true
    fi
    
    # 2. Ejecutar linting
    if ! run_linting; then
        echo -e "${YELLOW}⚠️ Linting issues detected but allowing commit${NC}"
    fi
    
    # 3. Ejecutar tests (opcional, depende de la velocidad)
    if ! run_tests; then
        echo -e "${YELLOW}⚠️ Test failures detected but allowing commit${NC}"
        echo -e "${YELLOW}   Fix tests before pushing to main branch${NC}"
    fi
    
    # 4. Verificaciones adicionales (no bloquean)
    check_todos
    check_file_sizes
    
    # Solo fallar por secretos detectados
    if $checks_failed; then
        echo -e "${RED}❌ Pre-commit checks failed${NC}"
        echo -e "${RED}   Fix security issues before committing${NC}"
        return 1
    fi
    
    echo -e "${GREEN}✅ Pre-commit checks completed${NC}"
    return 0
}

# Ejecutar main function
main "$@"