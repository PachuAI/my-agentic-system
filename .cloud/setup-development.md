# Configurar Entorno de Desarrollo

**NOTA**: Este comando solo se ejecuta DESPUÉS de completar todo el análisis y plan de acción.

## Prerequisitos
Antes de ejecutar este comando, debe existir:
- `.output/prd-analysis.md`
- `.output/tech-stack-decision.md`
- `.output/architecture-design.md`
- `.output/action-plan.md`

## 1. Configuración del Proyecto
- Crear estructura de carpetas según arquitectura definida
- Inicializar repositorio Git
- Configurar .gitignore apropiado
- Crear archivos de configuración del stack elegido

## 2. Instalación de Dependencias
- Instalar frameworks y librerías según tech-stack-decision.md
- Configurar herramientas de desarrollo (linters, formatters)
- Configurar testing framework
- Configurar CI/CD básico

## 3. Configuración de Base de Datos
- Crear esquema inicial según architecture-design.md
- Configurar migraciones
- Crear seeds de datos de prueba
- Configurar conexiones de desarrollo/testing

## 4. Configuración de Entorno
- Variables de entorno de desarrollo
- Configuración de servicios externos (APIs)
- Certificados SSL para desarrollo local
- Docker containers si aplica

## 5. Verificación
- Ejecutar tests iniciales
- Verificar que build funciona
- Confirmar que desarrollo server inicia
- Validar conexión a base de datos

## 6. Documentación Inicial
- Crear README.md del proyecto
- Documentar comandos de desarrollo
- Crear CLAUDE.md con contexto del proyecto
- Configurar templates de issues/PRs

## 7. Primer Commit
- Hacer commit inicial con estructura base
- Crear branch de desarrollo
- Configurar branch protection rules
- Hacer primer deploy a entorno de desarrollo

## Output
- Proyecto completamente configurado y listo para desarrollo
- Documentación actualizada
- Primer milestone del action-plan completado