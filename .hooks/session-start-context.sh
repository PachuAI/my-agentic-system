#!/bin/bash
# Hook para establecer contexto al iniciar sesión

echo "🚀 Estableciendo contexto del proyecto..."

# Verificar si existe PRD
if [ -f "PRD.md" ] || [ -f "prd.md" ] || [ -f "requirements.md" ]; then
    echo "📄 PRD detectado - Proyecto en fase de análisis"
    echo "Ejecuta los siguientes comandos en orden:"
    echo "1. /analyze-prd"
    echo "2. /tech-stack-recommendation"
    echo "3. /architecture-design"
    echo "4. /create-action-plan"
    echo ""
else
    echo "⚠️ No se encontró PRD.md"
    echo "Para usar esta plantilla semilla:"
    echo "1. Agrega tu PRD.md al proyecto"
    echo "2. Reinicia Claude Code para activar el análisis"
    echo ""
fi

# Verificar si ya hay análisis previo
if [ -d ".output" ] && [ "$(ls -A .output)" ]; then
    echo "📈 Análisis previo encontrado en .output/"
    echo "Archivos disponibles:"
    ls -la .output/ | grep -v "^d" | awk '{print "  - " $9}'
    echo ""
fi

# Detectar stack si el proyecto ya está configurado
if [ -f "package.json" ]; then
    echo "📦 Proyecto Node.js detectado"
elif [ -f "composer.json" ]; then
    echo "🐘 Proyecto PHP detectado"  
elif [ -f "requirements.txt" ]; then
    echo "🐍 Proyecto Python detectado"
elif [ -f "Cargo.toml" ]; then
    echo "🦀 Proyecto Rust detectado"
fi

# Verificar CLAUDE.md
if [ ! -f "CLAUDE.md" ]; then
    echo "⚠️ No se encontró CLAUDE.md"
    echo "Este archivo se creará automáticamente durante el análisis"
else
    echo "✅ CLAUDE.md encontrado - Contexto del proyecto disponible"
fi

echo ""
echo "🌱 Sistema de plantilla semilla activo"
echo "Documentación: README.md | Instrucciones: INIT-INSTRUCTIONS.md"
echo ""