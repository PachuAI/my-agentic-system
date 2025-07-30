# Diseñar Arquitectura

Crea diseño arquitectónico detallado SIN escribir código, basado en stack elegido.

## Prerequisitos
- `.output/current/analysis.md` completado
- `.output/current/stack-decision.md` aprobado

## Arquitecturas por Stack

### Laravel Architecture

#### Monolithic Laravel
```
app/
├── Http/Controllers/     # Request handling
├── Models/              # Eloquent models  
├── Services/            # Business logic
├── Repositories/        # Data access layer
├── Jobs/               # Background processing
├── Events/             # Event-driven features
├── Notifications/      # User notifications
└── Console/Commands/   # Artisan commands

resources/
├── views/              # Blade templates
├── js/                # Frontend assets
└── css/               # Styling

database/
├── migrations/         # Schema changes
├── seeders/           # Test data
└── factories/         # Model factories
```

#### Laravel API + Next.js
```
backend/ (Laravel)
├── app/Http/Controllers/Api/  # API controllers
├── app/Services/             # Business logic
├── app/Models/               # Eloquent models
└── routes/api.php           # API routes

frontend/ (Next.js)
├── app/                     # App router (Next.js 13+)
├── components/              # Reusable components
├── lib/                     # Utilities, API clients
├── hooks/                   # Custom React hooks
└── types/                   # TypeScript definitions
```

### Next.js Architecture

#### App Router (Recommended)
```
app/
├── (auth)/              # Route groups
├── dashboard/           # Nested routes
├── api/                 # API routes
├── globals.css          # Global styles
├── layout.tsx           # Root layout
└── page.tsx            # Home page

components/
├── ui/                  # UI components
├── forms/              # Form components
└── layouts/            # Layout components

lib/
├── auth.ts             # Authentication logic
├── db.ts               # Database connection
├── utils.ts            # Utility functions
└── validations.ts      # Zod schemas
```

### React SPA Architecture

#### Feature-Based Structure
```
src/
├── components/
│   ├── common/          # Shared components
│   └── ui/             # UI library components
├── features/
│   ├── auth/           # Authentication feature
│   ├── dashboard/      # Dashboard feature
│   └── profile/        # User profile feature
├── hooks/              # Custom hooks
├── services/           # API services
├── store/              # State management
├── types/              # TypeScript types
└── utils/              # Utility functions
```

### Python Web Architecture

#### Django Project
```
project/
├── apps/
│   ├── users/          # User management
│   ├── core/           # Core functionality
│   └── api/            # API endpoints
├── config/
│   ├── settings/       # Environment settings
│   ├── urls.py         # URL configuration
│   └── wsgi.py         # WSGI configuration
├── static/             # Static files
├── templates/          # Django templates
└── requirements/       # Dependencies
```

## Database Design

### Laravel/PHP Projects
- **Eloquent relationships** design
- **Migration strategy** for schema changes
- **Indexing strategy** for performance
- **Caching layers** (Redis, Memcached)

### Next.js Projects
- **Prisma schema** design
- **Database choice** (PostgreSQL, MySQL, SQLite)
- **Connection pooling** strategy
- **Edge database** considerations (PlanetScale, Neon)

### Python Projects
- **Django ORM** model relationships
- **Database migrations** strategy
- **Query optimization** patterns
- **Async database** support (if needed)

## API Design

### RESTful API Patterns
```
GET    /api/users           # List users
POST   /api/users           # Create user
GET    /api/users/{id}      # Get user
PUT    /api/users/{id}      # Update user
DELETE /api/users/{id}      # Delete user
```

### GraphQL Considerations
- When to use GraphQL vs REST
- Schema design principles
- N+1 problem mitigation
- Caching strategies

## Authentication Architecture

### Laravel
- **Sanctum** for SPA authentication
- **Passport** for OAuth
- **Breeze** for simple auth
- **Fortify** for headless auth

### Next.js
- **NextAuth.js** for full-stack auth
- **Auth0** for managed auth
- **Clerk** for modern auth UX
- **Custom JWT** implementation

### Python
- **Django Auth** system
- **Django REST Framework** auth
- **FastAPI Users** for FastAPI
- **OAuth2** implementations

## Deployment Architecture

### Laravel Deployment
```
Production Environment:
├── Web Server (Nginx)
├── PHP-FPM
├── Laravel Application
├── Redis (Cache/Sessions)
├── Database (MySQL/PostgreSQL)
└── Queue Workers
```

### Next.js Deployment  
```
Vercel (Recommended):
├── Edge Functions
├── Serverless Functions
├── Static Assets (CDN)
└── Database Connection

Self-Hosted:
├── Reverse Proxy (Nginx)
├── Node.js Application
├── PM2 Process Manager
└── Database Connection
```

## Context-7 Research for Architecture

Investigar patrones específicos:
- **Authentication patterns** para el stack elegido
- **State management** best practices
- **Error handling** strategies
- **Testing architecture** patterns
- **Performance optimization** techniques

## Output

Generar `.output/v1.0_architecture.md` con:
- **Component diagram** (texto/mermaid)
- **Data flow** documentation
- **API contracts** definition
- **Database schema** design
- **Deployment strategy** detallada
- **Security considerations** por layer
- **Performance considerations** por component