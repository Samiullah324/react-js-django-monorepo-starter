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

```bash
# Build and start all services
docker-compose up --build

# Start in background
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Reset database
docker-compose down -v
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
- ✅ Environment-specific Dockerfiles
- ✅ Setup scripts for easy deployment
- ✅ Individual .gitignore and README for each service
- ✅ Development-optimized Docker setup
- ✅ Hot reload for development

