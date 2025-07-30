#!/bin/bash
# Hook para validar antes de escribir archivos

echo "🔍 Validando antes de escribir archivo..."

# Verificar que el análisis esté completo antes de escribir código
if [[ "$CLAUDE_TOOL_PATH" == *.js || "$CLAUDE_TOOL_PATH" == *.ts || "$CLAUDE_TOOL_PATH" == *.jsx || "$CLAUDE_TOOL_PATH" == *.tsx || "$CLAUDE_TOOL_PATH" == *.py || "$CLAUDE_TOOL_PATH" == *.php ]]; then
    
    # Si es código, verificar que tengamos el plan
    if [ ! -f ".output/action-plan.md" ]; then
        echo "❌ ERROR: Intentando escribir código sin completar el análisis"
        echo "Debes completar primero:"
        echo "1. /analyze-prd"
        echo "2. /tech-stack-recommendation"
        echo "3. /architecture-design"
        echo "4. /create-action-plan"
        echo ""
        echo "Solo después ejecuta /setup-development para iniciar el desarrollo"
        exit 1
    fi
    
    echo "✅ Plan de acción encontrado - Procediendo con escritura de código"
fi

# Verificar que no estemos sobrescribiendo archivos importantes sin confirmación
if [[ "$CLAUDE_TOOL_PATH" == "package.json" || "$CLAUDE_TOOL_PATH" == "composer.json" || "$CLAUDE_TOOL_PATH" == "requirements.txt" ]]; then
    echo "⚠️ Modificando archivo de configuración importante: $CLAUDE_TOOL_PATH"
fi

echo "✅ Validación completada"