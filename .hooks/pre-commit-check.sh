#!/bin/bash
# Hook para verificaciones antes de commits

echo "🔍 Verificando código antes del commit..."

# Ejecutar linters si están disponibles
if [ -f "package.json" ] && grep -q "\"lint\":" package.json; then
    echo "🔧 Ejecutando linter..."
    npm run lint
    if [ $? -ne 0 ]; then
        echo "❌ Linting falló - Corrige los errores antes del commit"
        exit 1
    fi
fi

# Ejecutar tests
if [ -f "package.json" ] && grep -q "\"test\":" package.json; then
    echo "🧪 Ejecutando tests..."
    npm test
    if [ $? -ne 0 ]; then
        echo "❌ Tests fallaron - Corrige antes del commit"
        exit 1
    fi
elif [ -f "composer.json" ] && [ -f "./vendor/bin/phpunit" ]; then
    echo "🧪 Ejecutando PHPUnit..."
    ./vendor/bin/phpunit
    if [ $? -ne 0 ]; then
        echo "❌ Tests PHPUnit fallaron"
        exit 1
    fi
fi

# Buscar TODO o FIXME no resueltos en archivos de código
echo "🔍 Buscando TODOs y FIXMEs..."
if grep -r "TODO\|FIXME" --include="*.js" --include="*.ts" --include="*.jsx" --include="*.tsx" --include="*.py" --include="*.php" . 2>/dev/null; then
    echo "⚠️ Se encontraron TODOs o FIXMEs pendientes"
    echo "Considera resolverlos antes del commit"
fi

# Verificar que no hay console.log en producción
if grep -r "console\.log" --include="*.js" --include="*.ts" --include="*.jsx" --include="*.tsx" . 2>/dev/null; then
    echo "⚠️ console.log detectado - Considera usar logging apropiado"
fi

# Verificar archivos grandes
echo "📁 Verificando tamaño de archivos..."
find . -type f -size +1M -not -path "./node_modules/*" -not -path "./.git/*" -not -path "./vendor/*" 2>/dev/null | while read file; do
    echo "⚠️ Archivo grande detectado: $file"
done

echo "✅ Pre-commit checks completados"