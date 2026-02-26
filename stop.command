#!/bin/bash
# ============================================================
#  stop.command — Stop the PHP environment
#  Double-click this file to stop all services
# ============================================================

cd "$(dirname "$0")"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║    PHP Docker Environment — Stopping     ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "⏳  Stopping services..."
echo ""

docker compose stop

echo ""
echo "✅  All services have been stopped."
echo "    Your files and data are preserved."
echo ""
read -p "Press Enter to close..."
