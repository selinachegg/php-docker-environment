#!/bin/bash
# ============================================================
#  start.command — Launch the PHP environment
#  Double-click this file to start all services
# ============================================================

# Navigate to the project folder (even if launched from Finder)
cd "$(dirname "$0")"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   PHP Docker Environment — Starting      ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Check that Docker Desktop is running
if ! docker info > /dev/null 2>&1; then
    echo "⚠️  Docker Desktop is not running!"
    echo ""
    echo "   → Open Docker Desktop and wait until it's ready"
    echo "   → Then run this file again"
    echo ""
    read -p "Press Enter to close..."
    exit 1
fi

echo "✅  Docker Desktop is ready"
echo ""
echo "⏳  Starting services..."
echo ""

# Launch all containers
docker compose up -d

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║           Available services             ║"
echo "╠══════════════════════════════════════════╣"
echo "║  🌐  PHP Site    → localhost:8080        ║"
echo "║  🗄️   phpMyAdmin → localhost:8081        ║"
echo "║  🐳  Portainer   → localhost:9000        ║"
echo "║  🏠  Dashboard   → localhost:8082        ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Wait for services to be ready
echo "⏳  Waiting for services to start..."
sleep 5

# Open the dashboard in the browser
echo "🚀  Opening dashboard..."
open "http://localhost:8082"

echo ""
echo "✅  Environment started successfully!"
echo "    You can close this window."
echo ""
read -p "Press Enter to close..."
