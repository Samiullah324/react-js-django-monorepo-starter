#!/bin/bash

# Monorepo Setup Script
set -e

ENVIRONMENT=${1:-development}
SERVICE=${2:-all}

echo "🚀 Setting up monorepo..."
echo "Environment: $ENVIRONMENT"
echo "Service: $SERVICE"

# Copy environment file
echo "📝 Setting up environment files..."
if [ -f "environments/${ENVIRONMENT}.env" ]; then
    cp "environments/${ENVIRONMENT}.env" .env
    echo "✅ Copied environments/${ENVIRONMENT}.env to .env"
else
    cp env.example .env
    echo "⚠️  Using env.example as .env (edit as needed)"
fi

case $SERVICE in
    "frontend")
        echo "🎨 Starting frontend only..."
        cd frontend
        cp env.example .env
        docker-compose up --build
        ;;
    "backend")
        echo "🔧 Starting backend only..."
        cd backend
        cp env.example .env
        docker-compose up --build
        ;;
    "all"|*)
        echo "🐳 Starting full monorepo..."
        docker-compose up --build -d
        
        echo "⏳ Waiting for services to be ready..."
        sleep 10
        
        # Run database migrations
        echo "🗄️ Running database migrations..."
        docker-compose exec backend python manage.py migrate
        
        echo "👤 Creating superuser (skip if exists)..."
        docker-compose exec backend python manage.py shell -c "
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('Superuser created: admin/admin123')
else:
    print('Superuser already exists')
"
        
        echo "✅ Setup complete!"
        echo "📱 Frontend: http://localhost:3000"
        echo "🔗 Backend API: http://localhost:8000/api/"
        echo "⚙️  Admin Panel: http://localhost:8000/admin/"
        echo "👤 Admin credentials: admin/admin123"
        ;;
esac
