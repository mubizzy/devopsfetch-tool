#!/bin/bash

# Function to display help message
function display_help() {
    echo "Usage: $0 [OPTION]"
    echo "Options:"
    echo "  -p, --port [PORT]       Display all active ports and services, or detailed information about a specific port."
    echo "  -d, --docker [CONTAINER] List all Docker images and containers, or detailed information about a specific container."
    echo "  -n, --nginx [DOMAIN]    Display all Nginx domains and their ports, or detailed configuration information for a specific domain."
    echo "  -u, --users [USERNAME]  List all users and their last login times, or detailed information about a specific user."
    echo "  -t, --time [TIME_RANGE] Display activities within a specified time range."
    echo "  -h, --help              Display this help message."
}

# Function to display all active ports and services
function display_ports() {
    if [ -z "$1" ]; then
        echo "Active Ports and Services:"
        sudo netstat -tuln | awk 'NR>2 {print $4 "\t" $1 "\t" $7}' | column -t
    else
        echo "Detailed Information for Port $1:"
        sudo lsof -i :$1
    fi
}

# Function to list all Docker images and containers
function display_docker() {
    if [ -z "$1" ]; then
        echo "Docker Images:"
        sudo docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}"
        echo
        echo "Docker Containers:"
        sudo docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
    else
        echo "Detailed Information for Container $1:"
        sudo docker inspect $1
    fi
}

# Function to display all Nginx domains and their ports
function display_nginx() {
    if [ -z "$1" ]; then
        echo "Nginx Domains and Ports:"
        sudo nginx -T | grep "server_name" -A 1 | grep -v "^--" | sed 'N;s/\n/\t/' | column -t
    else
        echo "Detailed Configuration for Domain $1:"
        sudo nginx -T | grep -A 10 "server_name $1"
    fi
}

# Function to list all users and their last login times
function display_users() {
    if [ -z "$1" ]; then
        echo "Users and Last Login Times:"
        lastlog | column -t
    else
        echo "Detailed Information for User $1:"
        id $1
        last $1
    fi
}

# Function to display activities within a specified time range
function display_time_range() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Error: Both start and end times must be specified."
        echo "Usage: $0 -t 'YYYY-MM-DD HH:MM:SS' 'YYYY-MM-DD HH:MM:SS'"
        exit 1
    fi
    echo "Activities from $1 to $2:"
    sudo journalctl --since="$1" --until="$2" | less
}


# Function to set up systemd service
function setup_systemd_service() {
    echo "Setting up systemd service..."
    cat <<EOF | sudo tee /etc/systemd/system/devopsfetch.service
[Unit]
Description=DevOps Fetch Service
After=network.target

[Service]
Type=simple
ExecStart=$(pwd)/devopsfetch.sh monitor
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl daemon-reload
    sudo systemctl enable devopsfetch.service
    sudo systemctl start devopsfetch.service

    echo "Systemd service set up successfully."
}

# Function to monitor and log activities
function monitor_activities() {
    echo "Monitoring activities..."
    LOGFILE="/var/log/devopsfetch.log"
    while true; do
        {
            echo "Timestamp: $(date)"
            display_ports
            display_docker
            display_nginx
            display_users
            echo "----------------------------"
        } >> $LOGFILE
        sleep 60
    done
}

# Main function
function main() {
    case "$1" in
        -p|--port)
            display_ports $2
            ;;
        -d|--docker)
            display_docker $2
            ;;
        -n|--nginx)
            display_nginx $2
            ;;
        -u|--users)
            display_users $2
            ;;
        -t|--time)
            display_time_range $2 $3
            ;;
        -h|--help)
            display_help
            ;;
        monitor)
            monitor_activities
            ;;
        *)
            echo "Invalid option. Use -h or --help for usage instructions."
            ;;
    esac
}

# Run main function
main $@