#!/bin/bash

# TorOps
# by superjulien 
# > https://github.com/Superjulien
# > https://framagit.org/Superjulien
# V1.0.9

if [ "$EUID" -ne 0 ]; then
    echo "ERROR: This script must be run with sudo."
    exit 1
fi

if [ -z "$BASH_VERSION" ]; then
    echo "ERROR: This script must be run with the Bash shell (bash)."
    exit 1
fi

validate_option() {
    if ! [[ "$1" =~ ^[1-3qQ]$ ]]; then
        echo "Invalid option: $1. Please choose a valid option (1-3 or q to quit)."
        sleep 2
        return 1
    fi
    return 0
}

check_dependencies() {
    local dependencies=("systemctl" "wget" "proxychains" "curl" "tor")
    local missing_dependencies=()

    for dependency in "${dependencies[@]}"; do
        if ! command -v "$dependency" &> /dev/null; then
            missing_dependencies+=("$dependency")
        fi
    done

    if [ ${#missing_dependencies[@]} -gt 0 ]; then
        echo "ERROR: The following dependencies are not installed on your system:"
        for missing_dependency in "${missing_dependencies[@]}"; do
            echo "  - $missing_dependency"
        done
        echo "Please install all dependencies before continuing."
        exit 1
    fi
}

status_tor() {
    if systemctl is-active --quiet tor; then
        echo "Tor is already running."
        read -p "Do you want to (s)top, (r)estart, or do nothing? (s/r/n): " choice
        case "$choice" in
            [Ss]*)
                echo "Stopping Tor..."
                if systemctl stop tor; then
                    echo "Tor has been stopped successfully."
                else
                    echo "ERROR: Unable to stop Tor."
                fi
                ;;
            [Rr]*)
                echo "Restarting Tor..."
                if systemctl restart tor; then
                    echo "Tor has been restarted successfully."
                else
                    echo "ERROR: Unable to restart Tor."
                fi
                ;;
            *)
                echo "The Tor service has not been modified."
                ;;
        esac
    else
        read -p "Tor is not running. Do you want to start it? (y/n): " choice
        if [[ $choice =~ ^[Yy]$ ]]; then
            echo "Starting Tor..."
            if systemctl start tor; then
                echo "Tor has been started successfully."
            else
                echo "ERROR: Unable to start Tor."
            fi
        else
            echo "The Tor service has not been started."
        fi
    fi
    sleep 2
}

display_logo() {
    cat << "EOF"
 _____          _____           
|_   _|        |  _  |          
  | | ___  _ __| | | |_ __  ___ 
  | |/ _ \| '__| | | | '_ \/ __|
  | | (_) | |  \ \_/ / |_) \__ \
  \_/\___/|_|   \___/| .__/|___/
  Version 1.09       | |        
                     |_|
EOF
}

action_start() {
    echo "Starting the Tor service:"
    echo -n 'TOR [STARTING]'
    if service tor start; then
        echo -e '\rTOR [COMPLETED] '
    else
        echo -e '\rERROR: Unable to start TOR'
    fi
}

action_stop() {
    echo "Stopping the Tor service:"
    echo -n 'TOR [STOPPING]'
    if service tor stop; then
        echo -e '\rTOR [COMPLETED]'
    else
        echo -e '\rERROR: Unable to stop TOR'
    fi
}

action_newip() {
    echo "New IP Address:"
    echo -n 'REFRESH IP [START]'

    if [ "$(is_tor_active)" = "inactive" ]; then
        echo -e '\rERROR: Cannot refresh IP address because TOR is stopped'
    else
        sleep 0.5
        if systemctl reload tor; then
            echo -e '\rREFRESH IP [COMPLETED]'
        else
            echo -e '\rERROR: Unable to refresh IP address'
        fi
    fi
}

is_tor_active() {
    systemctl is-active tor
}

get_public_ip() {
    wget -qO- http://checkip.dyndns.org/ | sed -n 's/.*Current IP Address: \([0-9.]*\).*/\1/p'
}

check_dependencies
clear
display_logo

if [ $# -eq 0 ]; then
    echo "> Welcome to TorOps!"
    echo ""
    sleep 2
    status_tor
else
    case "$1" in
        start)
            action_start
            exit 0
            ;;
        stop)
            action_stop
            exit 0
            ;;
        refresh)
            action_newip
            exit 0
            ;;
        *)
            echo "Invalid command-line argument: $1"
            exit 1
            ;;
    esac
fi

while true; do
    clear
    public_ip=$(get_public_ip)
    tor_status=$(is_tor_active)

    if [ "$tor_status" = "inactive" ]; then
        ip_proxy="No TOR"
        tor_project=""
    else
        ip1=$(proxychains wget -qO- http://checkip.dyndns.org/ | sed -n 's/.*Current IP Address: \([0-9.]*\).*/\1/p')
        ip_proxy="(Proxy Address: $ip1)"
        tor_project=$(curl --socks5 localhost:9050 --socks5-hostname localhost:9050 -s https://check.torproject.org/ | grep -m 1 Congratulations)
    fi

    echo "TorOps:"
    echo ""
    echo "Public IP Address: $public_ip | Tor Status: $tor_status | $ip_proxy"
    echo "$tor_project"
    echo ""
    echo "Selection:"
    cat <<EOT
    1 )  Start TOR
    2 )  Stop TOR
    3 )  Refresh IP
    q )  QUIT
EOT
    echo ">>"
    tput cuu1
    tput cuf 3
    read -r answer
    clear

    if ! validate_option "$answer"; then
        continue
    fi

    case "$answer" in
        1)
            action_start
            ;;
        2)
            action_stop
            ;;
        3)
            action_newip
            ;;
        [qQ])
            echo "Goodbye..."
            exit 0
            ;;
        *)
            echo "Please choose a valid option from the menu"
            ;;
    esac

    echo ""
    echo "PRESS ENTER TO RETURN TO THE MENU"
    read -r dummy
done
