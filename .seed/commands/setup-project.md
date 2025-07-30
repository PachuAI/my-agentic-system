# Setup Project

**⚠️ EJECUTAR SOLO DESPUÉS DE COMPLETAR TODO EL ANÁLISIS**

Este comando configura el proyecto real basado en todos los análisis completados.

## Prerequisitos Obligatorios
- `.output/current/analysis.md` ✅
- `.output/current/stack-decision.md` ✅  
- `.output/current/architecture.md` ✅
- `.output/current/dev-plan.md` ✅

## Stack-Specific Setup

### Laravel Project Setup

#### Monolithic Laravel
```bash
# 1. Create Laravel project
composer create-project laravel/laravel project-name
cd project-name

# 2. Configure environment
cp .env.example .env
php artisan key:generate

# 3. Setup database
php artisan migrate
php artisan db:seed

# 4. Install additional packages
composer require laravel/sanctum laravel/breeze
npm install && npm run build

# 5. Configure services  
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
```

#### Laravel API + Next.js
```bash
# Backend setup
composer create-project laravel/laravel backend
cd backend
composer require laravel/sanctum
php artisan install:api

# Frontend setup  
cd ..
npx create-next-app@latest frontend --typescript --tailwind --app
cd frontend
npm install axios @types/node
```

### Next.js Project Setup

#### Full-Stack Next.js  
```bash
# 1. Create Next.js project
npx create-next-app@latest project-name --typescript --tailwind --app
cd project-name

# 2. Install dependencies based on architecture
npm install prisma @prisma/client
npm install next-auth
npm install zod react-hook-form @hookform/resolvers

# 3. Setup database
npx prisma init
npx prisma generate
npx prisma db push

# 4. Configure authentication
# (Based on architecture design)
```

### React SPA Setup
```bash
# 1. Create React app
npx create-react-app project-name --template typescript
cd project-name

# 2. Install routing and state management
npm install react-router-dom @reduxjs/toolkit react-redux
# OR
npm install zustand

# 3. Install UI and utilities
npm install axios react-query
npm install @headlessui/react @heroicons/react

# 4. Setup development tools
npm install -D @types/react @types/react-dom
```

### Python Web Setup

#### Django Project
```bash
# 1. Create virtual environment
python -m venv venv
source venv/bin/activate  # Linux/Mac
# venv\Scripts\activate   # Windows

# 2. Install Django and dependencies  
pip install django djangorestframework
pip install django-cors-headers python-decouple

# 3. Create project
django-admin startproject project_name
cd project_name
python manage.py startapp core

# 4. Initial migration
python manage.py migrate  
python manage.py createsuperuser
```

#### FastAPI Project
```bash
# 1. Setup environment
python -m venv venv
source venv/bin/activate

# 2. Install FastAPI stack
pip install fastapi uvicorn sqlalchemy alembic
pip install python-multipart python-jose[cryptography]

# 3. Create project structure
mkdir app
touch app/__init__.py app/main.py app/models.py
```

## Project Structure Creation

### Standard Folder Structure
```bash
# Create standard directories based on architecture
mkdir -p {src,tests,docs,scripts,config}

# Laravel specific
mkdir -p {app/Services,app/Repositories,app/Http/Resources}

# Next.js specific  
mkdir -p {components/ui,lib,hooks,types}

# React specific
mkdir -p {src/components,src/hooks,src/services,src/store}

# Python specific
mkdir -p {apps,config,static,templates,requirements}
```

## Configuration Files

### Development Tools Setup
```bash
# ESLint & Prettier for JS/TS projects
npm install -D eslint prettier eslint-config-prettier
npx eslint --init

# PHP CS Fixer for Laravel
composer require --dev friendsofphp/php-cs-fixer

# Black & Flake8 for Python
pip install black flake8 mypy
```

### Environment Configuration
```bash
# Copy environment templates
cp .env.example .env.local
cp .env.example .env.testing

# Generate application keys/secrets
# (Stack specific commands)
```

## Database Setup

### Laravel Database
```bash
# Run migrations
php artisan migrate

# Seed database
php artisan db:seed

# Create storage link
php artisan storage:link
```

### Next.js Database  
```bash
# Setup Prisma
npx prisma generate
npx prisma db push
npx prisma db seed
```

### Python Database
```bash
# Django
python manage.py makemigrations
python manage.py migrate

# FastAPI + Alembic
alembic init alembic
alembic revision --autogenerate -m "Initial migration"
alembic upgrade head
```

## Testing Setup

### Laravel Testing
```bash
# Install testing tools
composer require --dev phpunit/phpunit pestphp/pest

# Create test database
touch database/database.sqlite
```

### JavaScript Testing
```bash
# Jest + Testing Library
npm install -D jest @testing-library/react @testing-library/jest-dom

# Playwright for E2E
npm install -D @playwright/test
npx playwright install
```

### Python Testing
```bash
# Pytest setup
pip install pytest pytest-django pytest-asyncio
pip install pytest-cov factory-boy
```

## CI/CD Setup

### GitHub Actions
```yaml
# .github/workflows/ci.yml (based on stack)
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      # Stack-specific steps from architecture
```

## First Deploy

### Vercel (Next.js)
```bash
npm install -g vercel
vercel login  
vercel --prod
```

### Laravel Forge/Vapor
```bash
# Configure deployment based on architecture decisions
```

### Railway/Render (General)
```bash
# Setup deployment configuration
```

## Verification Checklist

### Development Environment
- [ ] **Project builds** successfully
- [ ] **Development server** starts without errors
- [ ] **Database connection** working
- [ ] **Tests run** and pass (basic tests)

### Tools & Automation
- [ ] **Linting** configured and working
- [ ] **Code formatting** on save
- [ ] **Git hooks** configured
- [ ] **Environment variables** loaded correctly

### Basic Functionality
- [ ] **Home page** loads correctly
- [ ] **API endpoints** responding (if applicable)
- [ ] **Authentication** scaffold working
- [ ] **Database queries** executing

## Output

Una vez completado:
- ✅ **Proyecto configurado** según arquitectura diseñada
- ✅ **Entorno de desarrollo** funcional
- ✅ **Tests básicos** pasando
- ✅ **CI/CD pipeline** configurado
- ✅ **Primera versión** deployada

**Milestone 1 (Foundation Ready) COMPLETADO** 🎉

**Siguiente paso**: Comenzar desarrollo de features core (M2)