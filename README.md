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
├── frontend/           # Next.js 15 application
│   └── src/
│       ├── app/        # App Router pages
│       ├── components/ # Reusable components
│       │   ├── ui/     # Base UI components
│       │   └── features/ # Feature-specific components
│       ├── lib/        # Utility functions
│       ├── hooks/      # Custom React hooks
│       ├── styles/     # Global styles
│       ├── types/      # TypeScript definitions
│       └── context/    # React contexts
├── backend/            # Django 5.2.2 API
│   ├── config/         # Django settings
│   └── apps/           # Django applications
├── docker-compose.yml  # Container orchestration
└── README.md
```

## Quick Start

1. **Clone and setup environment:**
   ```bash
   git clone <repository-url>
   cd next-js-django-monorepo-starter
   cp env.example .env
   ```

2. **Start all services:**
   ```bash
   docker-compose up --build
   ```

3. **Access the applications:**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000/api/
   - Django Admin: http://localhost:8000/admin/

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

Copy `env.example` to `.env` and update:

```bash
# Database
POSTGRES_DB=monorepo_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

# Django
SECRET_KEY=your-secret-key-here
DEBUG=True

# Frontend
NEXT_PUBLIC_API_URL=http://localhost:8000
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
- ✅ Development-optimized Docker setup
- ✅ Environment variable management
- ✅ Hot reload for development

