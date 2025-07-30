#!/bin/bash
# Hook para ejecutar tests después de generar código

# Solo ejecutar si se modificaron archivos de código
if [[ "$CLAUDE_TOOL_NAME" == "Write" || "$CLAUDE_TOOL_NAME" == "MultiEdit" ]]; then
    if [[ "$CLAUDE_TOOL_PATH" == *.js || "$CLAUDE_TOOL_PATH" == *.ts || "$CLAUDE_TOOL_PATH" == *.jsx || "$CLAUDE_TOOL_PATH" == *.tsx || "$CLAUDE_TOOL_PATH" == *.py || "$CLAUDE_TOOL_PATH" == *.php ]]; then
        
        echo "🧪 Ejecutando tests automáticos después de modificación de código..."
        
        # Detectar y ejecutar framework de testing
        if [ -f "package.json" ] && grep -q "\"test\":" package.json; then
            echo "📦 Ejecutando tests de Node.js..."
            npm test -- --passWithNoTests --silent
            if [ $? -eq 0 ]; then
                echo "✅ Tests pasaron correctamente"
            else
                echo "❌ Tests fallaron - Revisar implementación"
            fi
            
        elif [ -f "composer.json" ] && grep -q "phpunit" composer.json; then
            echo "🐘 Ejecutando PHPUnit..."
            if [ -f "./vendor/bin/phpunit" ]; then
                ./vendor/bin/phpunit --no-output
                if [ $? -eq 0 ]; then
                    echo "✅ Tests PHPUnit pasaron"
                else
                    echo "❌ Tests PHPUnit fallaron"
                fi
            fi
            
        elif [ -f "requirements.txt" ] && [ -f "pytest.ini" ]; then
            echo "🐍 Ejecutando pytest..."
            pytest -q
            if [ $? -eq 0 ]; then
                echo "✅ Tests pytest pasaron"
            else
                echo "❌ Tests pytest fallaron"
            fi
        else
            echo "🔍 No se detectó framework de testing configurado"
        fi
        
        # Verificar linting si está disponible
        if [ -f "package.json" ] && grep -q "\"lint\":" package.json; then
            echo "🔍 Ejecutando linter..."
            npm run lint --silent
            if [ $? -eq 0 ]; then
                echo "✅ Linting OK"
            else
                echo "⚠️ Problemas de linting detectados"
            fi
        fi
        
    fi
fi