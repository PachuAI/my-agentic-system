#!/bin/bash
# Sistema automático de versionado para outputs

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para logging
log() {
    echo -e "${BLUE}[VERSION]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# Crear estructura de directorios si no existe
setup_output_structure() {
    mkdir -p .output/{current,archive}
    
    # Crear .gitkeep para mantener estructura
    touch .output/current/.gitkeep
    touch .output/archive/.gitkeep
    
    log "Output structure initialized"
}

# Obtener próxima versión
get_next_version() {
    local base_name=$1
    local version_type=${2:-"minor"}  # major, minor, patch
    
    # Buscar última versión existente
    local last_version=$(ls .output/v*_${base_name}.md 2>/dev/null | \
                        grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | \
                        sort -V | tail -1)
    
    if [ -z "$last_version" ]; then
        echo "v1.0.0"
        return
    fi
    
    # Parsear versión actual
    local major=$(echo $last_version | cut -d'.' -f1 | sed 's/v//')
    local minor=$(echo $last_version | cut -d'.' -f2)
    local patch=$(echo $last_version | cut -d'.' -f3)
    
    # Incrementar según tipo
    case $version_type in
        "major")
            echo "v$((major + 1)).0.0"
            ;;
        "minor")
            echo "v${major}.$((minor + 1)).0"
            ;;
        "patch")
            echo "v${major}.${minor}.$((patch + 1))"
            ;;
        *)
            echo "v${major}.$((minor + 1)).0"
            ;;
    esac
}

# Versionar un archivo específico
version_file() {
    local file_path=$1
    local version_type=${2:-"minor"}
    local commit_message=${3:-"Auto-generated output"}
    
    if [ ! -f "$file_path" ]; then
        error "File not found: $file_path"
        return 1
    fi
    
    # Extraer nombre base del archivo
    local base_name=$(basename "$file_path" .md)
    
    # Obtener próxima versión
    local new_version=$(get_next_version "$base_name" "$version_type")
    
    # Crear nombre del archivo versionado
    local versioned_name="${new_version}_${base_name}.md"
    local versioned_path=".output/${versioned_name}"
    
    # Agregar metadata al archivo
    local temp_file=$(mktemp)
    {
        echo "---"
        echo "version: $new_version"
        echo "created_at: $(date -Iseconds)"
        echo "commit_message: \"$commit_message\""
        echo "base_name: $base_name"
        echo "previous_version: $(ls .output/v*_${base_name}.md 2>/dev/null | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | sort -V | tail -1 || echo 'none')"
        echo "---"
        echo ""
        cat "$file_path"
    } > "$temp_file"
    
    # Mover archivo versionado
    mv "$temp_file" "$versioned_path"
    
    # Actualizar symlink en current/
    ln -sf "../${versioned_name}" ".output/current/${base_name}.md"
    
    success "Versioned: ${versioned_name}"
    
    # Archivar versiones viejas (mantener solo últimas 5)
    archive_old_versions "$base_name"
    
    return 0
}

# Archivar versiones viejas
archive_old_versions() {
    local base_name=$1
    local keep_count=5
    
    # Obtener lista de versiones ordenadas
    local versions=($(ls .output/v*_${base_name}.md 2>/dev/null | sort -V))
    local total_versions=${#versions[@]}
    
    if [ $total_versions -gt $keep_count ]; then
        local archive_count=$((total_versions - keep_count))
        
        log "Archiving $archive_count old versions of $base_name"
        
        for ((i=0; i<archive_count; i++)); do
            local old_version=${versions[$i]}
            local archive_name="$(date +%Y%m%d)_$(basename "$old_version")"
            
            mv "$old_version" ".output/archive/$archive_name"
            log "Archived: $archive_name"
        done
    fi
}

# Listar versiones de un archivo
list_versions() {
    local base_name=$1
    
    if [ -z "$base_name" ]; then
        # Listar todos los archivos
        echo "📋 All versioned outputs:"
        ls .output/v*.md 2>/dev/null | while read file; do
            local version=$(echo "$file" | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+')
            local name=$(echo "$file" | sed 's/.*v[0-9]\+\.[0-9]\+\.[0-9]\+_\(.*\)\.md/\1/')
            local date=$(stat -c %y "$file" 2>/dev/null | cut -d' ' -f1 || stat -f %Sm -t %Y-%m-%d "$file" 2>/dev/null)
            echo "  $version - $name ($date)"
        done
    else
        # Listar versiones específicas
        echo "📋 Versions of $base_name:"
        ls .output/v*_${base_name}.md 2>/dev/null | while read file; do
            local version=$(echo "$file" | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+')
            local date=$(stat -c %y "$file" 2>/dev/null | cut -d' ' -f1 || stat -f %Sm -t %Y-%m-%d "$file" 2>/dev/null)
            local current_marker=""
            
            # Verificar si es la versión actual
            if [ -L ".output/current/${base_name}.md" ]; then
                local current_target=$(readlink ".output/current/${base_name}.md")
                if [[ "$current_target" == *"$version"* ]]; then
                    current_marker=" (current)"
                fi
            fi
            
            echo "  $version ($date)$current_marker"
        done
    fi
}

# Restaurar una versión específica
restore_version() {
    local base_name=$1
    local version=$2
    
    local versioned_file=".output/${version}_${base_name}.md"
    
    if [ ! -f "$versioned_file" ]; then
        error "Version not found: $versioned_file"
        return 1
    fi
    
    # Actualizar symlink
    ln -sf "../${version}_${base_name}.md" ".output/current/${base_name}.md"
    
    success "Restored $base_name to $version"
}

# Comparar dos versiones
diff_versions() {
    local base_name=$1
    local version1=$2
    local version2=$3
    
    local file1=".output/${version1}_${base_name}.md"
    local file2=".output/${version2}_${base_name}.md"
    
    if [ ! -f "$file1" ] || [ ! -f "$file2" ]; then
        error "One or both versions not found"
        return 1
    fi
    
    echo "📊 Differences between $version1 and $version2:"
    diff -u "$file1" "$file2" || true
}

# Función principal
main() {
    setup_output_structure
    
    case "${1:-help}" in
        "version")
            if [ -z "$2" ]; then
                error "Usage: version-output.sh version <file> [type] [message]"
                exit 1
            fi
            version_file "$2" "${3:-minor}" "${4:-Auto-generated output}"
            ;;
        "list")
            list_versions "$2"
            ;;
        "restore")
            if [ -z "$2" ] || [ -z "$3" ]; then
                error "Usage: version-output.sh restore <base_name> <version>"
                exit 1
            fi
            restore_version "$2" "$3"
            ;;
        "diff")
            if [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
                error "Usage: version-output.sh diff <base_name> <version1> <version2>"
                exit 1
            fi
            diff_versions "$2" "$3" "$4"
            ;;
        "help"|*)
            echo "🔄 Output Versioning System"
            echo ""
            echo "Usage:"
            echo "  version-output.sh version <file> [type] [message]  # Version a file"
            echo "  version-output.sh list [base_name]                 # List versions"
            echo "  version-output.sh restore <base_name> <version>    # Restore version"
            echo "  version-output.sh diff <base_name> <v1> <v2>       # Compare versions"
            echo ""
            echo "Version types: major, minor, patch"
            echo ""
            echo "Examples:"
            echo "  version-output.sh version .output/analysis.md minor 'Updated requirements'"
            echo "  version-output.sh list analysis"
            echo "  version-output.sh restore analysis v1.2.0"
            echo "  version-output.sh diff analysis v1.0.0 v1.1.0"
            ;;
    esac
}

# Ejecutar función principal con todos los argumentos
main "$@"