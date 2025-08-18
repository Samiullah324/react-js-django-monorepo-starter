# Next.js Django Monorepo

A full-stack monorepo template with Next.js 15 frontend and Django 5.2.2 backend.

## Tech Stack

### Frontend
- **Framework**: Next.js 15 with App Router
- **Runtime**: Bun
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **State Management**: React Query

### Backend
- **Framework**: Django 5.2.2
- **API**: Django REST Framework 3.15.2
- **Database**: PostgreSQL 16
- **Cache**: Redis 7

## Project Structure

```
├── frontend/              # Next.js 15 application (independent)
│   ├── src/              # Exact structure as specified
│   │   ├── app/          # App Router pages
│   │   ├── components/   # Reusable components
│   │   │   ├── ui/       # Base UI components
│   │   │   └── features/ # Feature-specific components
│   │   ├── lib/          # Utility functions
│   │   ├── hooks/        # Custom React hooks
│   │   ├── styles/       # Global styles
│   │   ├── types/        # TypeScript definitions
│   │   └── context/      # React contexts
│   ├── docker/           # Docker configurations
│   ├── docker-compose.yml # Frontend-only setup
│   ├── env.example       # Frontend environment variables
│   ├── .gitignore        # Frontend-specific ignores
│   └── README.md         # Frontend documentation
├── backend/              # Django 5.2.2 API (independent)
│   ├── config/           # Django settings
│   ├── apps/             # Django applications
│   ├── docker/           # Docker configurations
│   ├── docker-compose.yml # Backend-only setup (includes DB & Redis)
│   ├── env.example       # Backend environment variables
│   ├── .gitignore        # Backend-specific ignores
│   └── README.md         # Backend documentation
├── environments/         # Multi-environment configs
│   ├── development.env
│   ├── staging.env
│   └── production.env
├── scripts/              # Setup utilities
├── docker-compose.yml    # Root orchestration (links both services)
├── env.example           # Root environment variables
└── README.md             # This file
```

## Quick Start Options

### Option 1: Full Monorepo (Recommended)

1. **Clone and setup environment:**
   ```bash
   git clone <repository-url>
   cd next-js-django-monorepo-starter
   cp env.example .env
   # Or use: ./scripts/setup.sh development all
   ```

2. **Start all services:**
   ```bash
   docker-compose up --build
   ```

3. **Access the applications:**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000/api/
   - Django Admin: http://localhost:8000/admin/

### Option 2: Frontend Only

```bash
cd frontend
cp env.example .env
# Edit NEXT_PUBLIC_API_URL to point to your backend
docker-compose up --build
# Access at http://localhost:3000
```

### Option 3: Backend Only

```bash
cd backend
cp env.example .env
docker-compose up --build
# Access at http://localhost:8000/api/
# Includes PostgreSQL and Redis
```

### Option 4: Use Setup Script

```bash
# Full monorepo
./scripts/setup.sh development all

# Frontend only
./scripts/setup.sh development frontend

# Backend only
./scripts/setup.sh development backend
```

## Quick Test Commands

### Validate Configuration Before Starting

```bash
# Test full monorepo configuration
docker-compose config

# Test backend only configuration
cd backend && docker-compose config

# Test frontend only configuration
cd frontend && docker-compose config
```

### Start Services

```bash
# Full monorepo (recommended for development)
cp env.example .env
docker-compose up --build

# Backend only (includes PostgreSQL & Redis)
cd backend
cp env.example .env
docker-compose up --build

# Frontend only
cd frontend
cp env.example .env
docker-compose up --build
```

## Development

### Backend Setup (Local)
```bash
cd backend
python -m venv venv
source venv/bin/activate  # Linux/Mac
# or venv\Scripts\activate  # Windows
pip install -r requirements.txt
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

### Frontend Setup (Local)
```bash
cd frontend
bun install
bun dev
```

## Docker Commands

### Full Monorepo Commands
```bash
# Build and start all services
docker-compose up --build

# Start in background
docker-compose up -d

# View logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f backend
docker-compose logs -f frontend

# Stop services
docker-compose down

# Reset database (removes all data)
docker-compose down -v

# Rebuild specific service
docker-compose up --build backend
docker-compose up --build frontend
```

### Individual Service Commands

**Backend Commands:**
```bash
cd backend

# Start backend with database and redis
docker-compose up --build

# View backend logs
docker-compose logs -f backend

# Run Django commands
docker-compose exec backend python manage.py migrate
docker-compose exec backend python manage.py createsuperuser
docker-compose exec backend python manage.py collectstatic

# Stop backend services
docker-compose down
```

**Frontend Commands:**
```bash
cd frontend

# Start frontend only
docker-compose up --build

# View frontend logs
docker-compose logs -f frontend

# Run Bun commands
docker-compose exec frontend bun install
docker-compose exec frontend bun build

# Stop frontend service
docker-compose down
```

## Environment-Specific Builds

You can build for different environments using the `ENVIRONMENT` variable:

```bash
# Development build (default)
ENVIRONMENT=development docker-compose up --build

# Production build
ENVIRONMENT=production docker-compose up --build

# Using environment files
cp environments/production.env .env
docker-compose up --build
```

## API Endpoints

- `GET /api/health/` - Health check
- `POST /api/auth/users/` - User registration
- `POST /api/auth/token/login/` - User login
- `POST /api/auth/token/logout/` - User logout

## Environment Variables

### Root Monorepo (.env)
Copy `env.example` to `.env` and update:

```bash
# Project Configuration
PROJECT_NAME=monorepo-starter
ENVIRONMENT=development

# Database
POSTGRES_DB=monorepo_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

# Django Backend
SECRET_KEY=your-secret-key-here-change-in-production
DEBUG=True
BACKEND_PORT=8000
BACKEND_CONTAINER_NAME=${PROJECT_NAME}-backend

# Frontend
NEXT_PUBLIC_API_URL=http://localhost:${BACKEND_PORT}
FRONTEND_PORT=3000
FRONTEND_CONTAINER_NAME=${PROJECT_NAME}-frontend

# Services (Dynamic Container Names)
DB_CONTAINER_NAME=${PROJECT_NAME}-db
REDIS_CONTAINER_NAME=${PROJECT_NAME}-redis
NETWORK_NAME=${PROJECT_NAME}-network
```

### Individual Service Environments
- **Frontend**: `frontend/env.example` → `frontend/.env`
- **Backend**: `backend/env.example` → `backend/.env`
- **Multi-env**: `environments/[development|staging|production].env`

## Access Points

### Full Monorepo
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000/api/
- **Django Admin**: http://localhost:8000/admin/
- **PostgreSQL**: localhost:5432
- **Redis**: localhost:6379

### Backend Only
- **Backend API**: http://localhost:8000/api/
- **Django Admin**: http://localhost:8000/admin/
- **PostgreSQL**: localhost:5432 (included)
- **Redis**: localhost:6379 (included)

### Frontend Only
- **Frontend**: http://localhost:3000
- **Note**: Configure `NEXT_PUBLIC_API_URL` to point to your backend

## Dynamic Container Names

All container names are automatically generated from the `PROJECT_NAME` environment variable:

### Root Monorepo (from root `.env`)
```bash
PROJECT_NAME=monorepo-starter
# Creates containers:
# - monorepo-starter-frontend
# - monorepo-starter-backend
# - monorepo-starter-db
# - monorepo-starter-redis
```

### Backend Only (from `backend/.env`)
```bash
PROJECT_NAME=backend-app
# Creates containers:
# - backend-app-backend
# - backend-app-db
# - backend-app-redis
```

### Frontend Only (from `frontend/.env`)
```bash
PROJECT_NAME=frontend-app
# Creates containers:
# - frontend-app-frontend
```

## Best Practices Included

### Django
- ✅ Latest Django 5.2.2 with best practices
- ✅ Custom User model
- ✅ Django REST Framework setup
- ✅ CORS configuration
- ✅ Environment-based settings
- ✅ Security settings for production

### Next.js
- ✅ Latest Next.js 15 with App Router
- ✅ TypeScript configuration
- ✅ Tailwind CSS setup
- ✅ React Query for state management
- ✅ Proper project structure
- ✅ API client with interceptors

### DevOps
- ✅ Docker containers for all services
- ✅ Independent Docker Compose files for each service
- ✅ Root Docker Compose linking both services
- ✅ Dynamic container names from environment variables
- ✅ Multi-environment support (dev/staging/production)
- ✅ Environment-specific Dockerfiles (development/production)
- ✅ Setup scripts for easy deployment
- ✅ Individual .gitignore and README for each service
- ✅ Development-optimized Docker setup
- ✅ Hot reload for development
- ✅ Docker configurations in dedicated `docker/` folders
- ✅ Configuration validation commands
- ✅ Comprehensive logging and debugging support

## Troubleshooting

### Common Issues

**1. Port conflicts:**
```bash
# Check if ports are in use
lsof -i :3000  # Frontend
lsof -i :8000  # Backend
lsof -i :5432  # PostgreSQL
lsof -i :6379  # Redis

# Change ports in .env file
FRONTEND_PORT=3001
BACKEND_PORT=8001
```

**2. Container name conflicts:**
```bash
# Remove existing containers
docker-compose down
docker system prune -f

# Change project name in .env
PROJECT_NAME=my-unique-name
```

**3. Volume permission issues:**
```bash
# Reset volumes
docker-compose down -v
docker volume prune -f
```

**4. Build cache issues:**
```bash
# Force rebuild without cache
docker-compose build --no-cache
docker-compose up --build
```

### Debugging Commands

```bash
# Check container status
docker-compose ps

# View container logs
docker-compose logs -f [service-name]

# Enter container for debugging
docker-compose exec backend bash
docker-compose exec frontend bash

# Check environment variables
docker-compose exec backend env
docker-compose exec frontend env

# Test database connection
docker-compose exec backend python manage.py dbshell

# Test Redis connection
docker-compose exec redis redis-cli ping
```

### Development Tips

1. **Hot Reload**: Changes to source code automatically reload in development mode
2. **Database Persistence**: Data persists between container restarts unless you use `docker-compose down -v`
3. **Environment Switching**: Use different `.env` files or `environments/` configs for different setups
4. **Service Independence**: Each service can be developed and deployed independently
5. **Network Communication**: Services communicate using container names as hostnames

