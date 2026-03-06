#!/bin/bash
# ============================================================
#  launcher.command — Main launcher
#  Double-click this file to manage the environment
# ============================================================

cd "$(dirname "$0")"

show_menu() {
    echo ""
    echo "=========================================="
    echo "   PHP Docker Environment — Launcher"
    echo "=========================================="
    echo ""
    echo "  Apache 2.4 | PHP 7.4 | MariaDB 10.6"
    echo "  phpMyAdmin  | Portainer"
    echo ""
    echo "  1)  Start"
    echo "  2)  Stop"
    echo "  3)  Restart"
    echo "  4)  Reset Portainer"
    echo "  5)  Quit"
    echo ""
}

check_docker() {
    if ! docker info > /dev/null 2>&1; then
        echo ""
        echo "  Docker Desktop is not running!"
        echo "  Open Docker Desktop, wait for the green whale icon,"
        echo "  then try again."
        echo ""
        read -p "  Press Enter to continue..."
        return 1
    fi
    return 0
}

while true; do
    clear
    show_menu
    read -p "  Your choice [1-5] : " choice

    case "$choice" in
        1)
            check_docker || continue
            echo ""
            echo "  Starting..."
            echo ""
            docker compose up -d
            if [ $? -eq 0 ]; then
                sleep 3
                open http://localhost:8082
                echo ""
                echo "  Environment started!"
                echo ""
                echo "  PHP Site:        localhost:8080"
                echo "  phpMyAdmin:      localhost:8081"
                echo "  Portainer:       localhost:9000"
                echo "  Dashboard:       localhost:8082"
            else
                echo ""
                echo "  Failed to start. Check Docker Desktop."
            fi
            echo ""
            read -p "  Press Enter to return to menu..."
            ;;
        2)
            echo ""
            echo "  Stopping..."
            echo ""
            docker compose stop
            if [ $? -eq 0 ]; then
                echo ""
                echo "  Environment stopped cleanly."
                echo "  Your PHP files and data are preserved."
            else
                echo ""
                echo "  Failed to stop."
            fi
            echo ""
            read -p "  Press Enter to return to menu..."
            ;;
        3)
            check_docker || continue
            echo ""
            echo "  Restarting..."
            echo ""
            docker compose down
            docker compose up -d
            if [ $? -eq 0 ]; then
                sleep 3
                echo ""
                echo "  Environment restarted!"
                echo ""
                echo "  PHP Site:        localhost:8080"
                echo "  phpMyAdmin:      localhost:8081"
                echo "  Portainer:       localhost:9000"
                echo "  Dashboard:       localhost:8082"
            else
                echo ""
                echo "  Failed to restart. Check Docker Desktop."
            fi
            echo ""
            read -p "  Press Enter to return to menu..."
            ;;
        4)
            echo ""
            echo "  Resetting Portainer..."
            echo "  (PHP files and database are NOT deleted)"
            echo ""
            docker compose stop portainer
            docker volume rm cours_portainer_data 2>/dev/null
            docker compose up -d portainer
            if [ $? -eq 0 ]; then
                sleep 2
                open http://localhost:9000
                echo ""
                echo "  Portainer reset!"
                echo "  Go to localhost:9000 NOW"
                echo "  to create a new admin account."
            else
                echo ""
                echo "  Failed to reset Portainer."
            fi
            echo ""
            read -p "  Press Enter to return to menu..."
            ;;
        5|q|Q)
            echo ""
            echo "  Goodbye!"
            echo ""
            exit 0
            ;;
        *)
            echo ""
            echo "  Invalid choice. Enter a number between 1 and 5."
            sleep 1
            ;;
    esac
done
