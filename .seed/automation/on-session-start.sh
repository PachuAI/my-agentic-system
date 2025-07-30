#!/bin/bash
# Hook optimizado para iniciar sesión con detección de stack

set -e

# Source stack detector
source "$(dirname "$0")/stack-detector.sh"

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m'

echo -e "${PURPLE}🌱 Agentic Seed System Starting...${NC}"
echo ""

# Verificar si existe PRD
if [ -f "PRD.md" ] || [ -f "prd.md" ] || [ -f "requirements.md" ]; then
    echo -e "${BLUE}📄 PRD detected - Analysis phase${NC}"
    echo "Execute commands in order:"
    echo -e "${YELLOW}1. /analyze${NC}              # Extract and structure requirements"
    echo -e "${YELLOW}2. /decide-stack${NC}          # Choose optimal technology stack" 
    echo -e "${YELLOW}3. /design-arch${NC}           # Design system architecture"
    echo -e "${YELLOW}4. /plan-dev${NC}              # Create development roadmap"
    echo -e "${YELLOW}5. /setup-project${NC}         # Initialize project (ONLY after all analysis)"
    echo ""
else
    echo -e "${RED}⚠️ No PRD found${NC}"
    echo "To use this seed system:"
    echo "1. Add your PRD.md to project root"
    echo "2. Restart Claude Code to trigger analysis"
    echo ""
fi

# Verificar análisis previo
if [ -d ".output" ] && [ "$(ls -A .output 2>/dev/null)" ]; then
    echo -e "${GREEN}📈 Previous analysis found in .output/${NC}"
    echo "Available files:"
    
    # Mostrar current symlinks si existen
    if [ -d ".output/current" ] && [ "$(ls -A .output/current 2>/dev/null)" ]; then
        echo -e "${BLUE}📌 Current versions:${NC}"
        for file in .output/current/*.md; do
            if [ -f "$file" ]; then
                local basename=$(basename "$file" .md)
                local version=$(readlink "$file" 2>/dev/null | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' || echo "unknown")
                echo "  - $basename ($version)"
            fi
        done
    else
        # Fallback: mostrar archivos directamente
        ls -la .output/ 2>/dev/null | grep -v "^d" | awk '{print "  - " $9}' | grep -v "^\s*-\s*$"
    fi
    echo ""
fi

# Detectar stack del proyecto actual
echo -e "${PURPLE}🔍 Analyzing project structure...${NC}"

# Ejecutar detección de stack
if main >/dev/null 2>&1; then
    
    # Cargar configuración si existe
    if [ -f ".agentic-stack.env" ]; then
        source .agentic-stack.env
        
        # Mostrar información del stack detectado
        case $AGENTIC_STACK in
            "laravel")
                echo -e "${GREEN}🐘 Laravel Project Detected${NC}"
                [ "$AGENTIC_FRAMEWORK_VERSION" != "unknown" ] && echo "   Version: $AGENTIC_FRAMEWORK_VERSION"
                [ "$AGENTIC_API_MODE" = "true" ] && echo "   • API mode enabled"
                [ "$AGENTIC_LIVEWIRE" = "true" ] && echo "   • Livewire detected"
                [ "$AGENTIC_INERTIA" = "true" ] && echo "   • Inertia.js detected"
                ;;
            "nextjs")
                echo -e "${GREEN}⚡ Next.js Project Detected${NC}"
                [ "$AGENTIC_FRAMEWORK_VERSION" != "unknown" ] && echo "   Version: $AGENTIC_FRAMEWORK_VERSION"
                [ "$AGENTIC_APP_ROUTER" = "true" ] && echo "   • App Router (Next.js 13+)"
                [ "$AGENTIC_PAGES_ROUTER" = "true" ] && echo "   • Pages Router"
                [ "$AGENTIC_API_ROUTES" = "true" ] && echo "   • API routes detected"
                ;;
            "react-cra"|"react-vite"|"react-custom")
                echo -e "${GREEN}⚛️ React Project Detected${NC}"
                echo "   Build: $AGENTIC_BUILD_TOOL"
                ;;
            "django")
                echo -e "${GREEN}🐍 Django Project Detected${NC}"
                [ "$AGENTIC_DRF" = "true" ] && echo "   • Django REST Framework"
                [ "$AGENTIC_ASYNC" = "true" ] && echo "   • Async support"
                ;;
            "flask"|"fastapi")
                echo -e "${GREEN}🐍 $AGENTIC_STACK Project Detected${NC}"
                [ "$AGENTIC_ASYNC" = "true" ] && echo "   • Async support"
                ;;
            *)
                echo -e "${YELLOW}❓ Generic project structure${NC}"
                ;;
        esac
        
        # Indicar si es fullstack
        if [ "$AGENTIC_FULLSTACK" = "true" ]; then
            echo -e "${BLUE}   📱 Full-stack configuration detected${NC}"
        fi
        
        # Indicar TypeScript
        if [ "$AGENTIC_TYPESCRIPT" = "true" ]; then
            echo -e "${BLUE}   📘 TypeScript configuration detected${NC}"
        fi
        
    fi
else
    echo -e "${YELLOW}❓ Could not detect stack - using generic mode${NC}"
fi

echo ""

# Verificar CLAUDE.md
if [ ! -f "CLAUDE.md" ]; then
    echo -e "${YELLOW}⚠️ No CLAUDE.md found${NC}"
    echo "This file will be created automatically during analysis"
else
    echo -e "${GREEN}✅ CLAUDE.md found - Project context available${NC}"
fi

# Mostrar comandos útiles basados en el estado del proyecto
echo ""
echo -e "${PURPLE}🛠️ Available Commands:${NC}"

if [ -f ".output/current/dev-plan.md" ]; then
    # Proyecto en desarrollo
    echo -e "${GREEN}Development Phase Active:${NC}"
    echo "  /test-auto          # Run automated tests"
    echo "  /code-review        # AI code review"
    echo "  /performance-check  # Performance audit"
elif [ -f ".output/current/analysis.md" ]; then
    # Análisis completado, continuar con stack/arquitectura
    echo -e "${BLUE}Analysis Complete - Continue with:${NC}"
    echo "  /decide-stack       # Choose technology stack"
    echo "  /design-arch        # Design architecture"
    echo "  /plan-dev          # Create development plan"
else
    # Inicio completo
    echo -e "${YELLOW}Start Analysis:${NC}"
    echo "  /analyze           # Begin PRD analysis"
fi

echo ""
echo -e "${PURPLE}📚 Documentation:${NC} README.md | Instructions: INIT-INSTRUCTIONS.md"
echo -e "${PURPLE}🔧 Version Control:${NC} .seed/automation/version-output.sh"
echo ""