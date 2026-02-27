#!/bin/bash
cd "$(dirname "$0")"

show_error() {
    osascript 2>/dev/null <<EOF
display dialog "$1" with title "PHP Docker Environment" buttons {"OK"} default button "OK" with icon stop
EOF
}

show_success() {
    osascript 2>/dev/null <<EOF
display dialog "$1" with title "PHP Docker Environment" buttons {"OK"} default button "OK" with icon note
EOF
}

while true; do
    ACTION=$(osascript 2>/dev/null <<'MENU'
set choices to {"▶  Start", "■  Stop", "↻  Restart", "🔄  Reset Portainer", "✕  Quit"}
set selected to choose from list choices with title "PHP Docker Environment" with prompt "Apache 2.4   PHP 7.4   MariaDB 10.6
phpMyAdmin   Portainer

Choose an action:" default items {"▶  Start"}
if selected is false then return "quit"
return item 1 of selected
MENU
    )

    case "$ACTION" in
        *"Restart"*)
            if ! docker info >/dev/null 2>&1; then
                show_error "Docker Desktop is not running!

Open Docker Desktop, wait for the green whale icon, then try again."
                continue
            fi
            osascript -e 'display dialog "Restarting... Please wait." with title "PHP Docker Environment" buttons {"OK"} default button "OK" giving up after 2 with icon note' 2>/dev/null &
            docker compose down 2>&1
            docker compose up -d 2>&1
            if [ $? -eq 0 ]; then
                sleep 3
                show_success "Environment restarted!

PHP Site:        localhost:8080
phpMyAdmin:  localhost:8081
Portainer:      localhost:9000
Dashboard:    localhost:8082"
            else
                show_error "Failed to restart. Check Docker Desktop."
            fi
            ;;
        *"Start"*)
            if ! docker info >/dev/null 2>&1; then
                show_error "Docker Desktop is not running!

Open Docker Desktop, wait for the green whale icon, then try again."
                continue
            fi
            osascript -e 'display dialog "Starting... Please wait." with title "PHP Docker Environment" buttons {"OK"} default button "OK" giving up after 2 with icon note' 2>/dev/null &
            docker compose up -d 2>&1
            if [ $? -eq 0 ]; then
                sleep 3
                open http://localhost:8082
                show_success "Environment started!

PHP Site:        localhost:8080
phpMyAdmin:  localhost:8081
Portainer:      localhost:9000
Dashboard:    localhost:8082"
            else
                show_error "Failed to start. Check Docker Desktop."
            fi
            ;;
        *"Stop"*)
            docker compose down 2>&1
            if [ $? -eq 0 ]; then
                show_success "Environment stopped cleanly.

Your PHP files and data are preserved."
            else
                show_error "Failed to stop."
            fi
            ;;
        *"Portainer"*)
            osascript -e 'display dialog "Resetting Portainer... Please wait." with title "PHP Docker Environment" buttons {"OK"} default button "OK" giving up after 2 with icon note' 2>/dev/null &
            docker compose stop portainer 2>&1
            docker volume rm cours_portainer_data 2>&1
            docker compose up -d portainer 2>&1
            if [ $? -eq 0 ]; then
                sleep 2
                open http://localhost:9000
                show_success "Portainer reset!

Go to localhost:9000 NOW to create a new admin account."
            else
                show_error "Failed to reset Portainer."
            fi
            ;;
        *"Quit"*|*"quit"*|"")
            exit 0
            ;;
    esac
done
