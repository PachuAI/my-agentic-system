# Changelog

## Version 2.0.0 - Major Restructure (2024-07-30)

### 🚀 Major Changes
- **Complete restructure**: `.cloud/` → `.seed/commands/` for clarity
- **New command names**: `/analyze`, `/decide-stack`, `/design-arch`, `/plan-dev`, `/setup-project`
- **Specialized stack detection**: Auto-optimizes for Laravel, Next.js, React, Python
- **Output versioning**: Automatic versioning with `v1.0.0_filename.md` format
- **Smart hooks**: Stack-aware validation and testing

### ✨ New Features
- **Stack detector**: Automatically detects and optimizes for your stack
- **Version control**: Full output versioning with history and rollback
- **Edge case handling**: Comprehensive error handling and recovery
- **Hook variables**: Complete documentation of available variables
- **MCP integration**: Structured approach to adding new MCPs

### 🛠️ Improved Components
- **Commands**: Simplified, stack-specific, with clear prerequisites
- **Templates**: DRY templates with stack-specific examples
- **Documentation**: Comprehensive guides for variables, edge cases, MCP integration
- **Hooks**: Specialized validation for each supported stack
- **Automation**: Smart detection and optimization workflows

### 📁 New Structure
```
.seed/                    # Core system (renamed from various dirs)
├── commands/             # Analysis commands (was .cloud/)
├── templates/            # Output templates (consolidated)
├── automation/           # Stack-aware hooks (was .hooks/)
└── docs/                 # System documentation

.output/                  # Versioned outputs
├── current/              # Symlinks to current versions
├── archive/              # Archived old versions
└── v*.*.*_*.md          # All versioned files
```

### 🔧 Technical Improvements
- **Performance**: Faster hook execution with stack detection
- **Reliability**: Graceful degradation when MCPs unavailable
- **Maintainability**: Clear separation of concerns
- **Extensibility**: Template system for adding new stacks/MCPs

### 📚 Documentation
- **Hook Variables**: Complete reference of available variables
- **Edge Cases**: Troubleshooting guide for complex scenarios  
- **MCP Integration**: Step-by-step guide for adding MCPs
- **Stack Optimization**: How the system adapts to different stacks

### 🔄 Migration from v1.x
Old structure is automatically cleaned up. No manual migration needed.
Commands remain similar but with new names:
- `/analyze-prd` → `/analyze`
- `/tech-stack-recommendation` → `/decide-stack`
- `/architecture-design` → `/design-arch`
- `/create-action-plan` → `/plan-dev`
- `/setup-development` → `/setup-project`

---

## Version 1.0.0 - Initial Release

### Features
- Basic PRD analysis workflow
- Generic templates for documentation
- Simple hook system
- Manual stack configuration
- Basic output management

### Supported Stacks
- Laravel (basic)
- Next.js (basic)
- React (basic)
- Python (basic)