#!/bin/bash

# Define log file
LOG_FILE="healthlog.txt"

# Get current date and time
NOW=$(date +"%Y-%m-%d %H:%M:%S")

# Start logging
{
    echo "----------------------------------------"
    echo "System Health Check - $NOW"
    echo "----------------------------------------"

    # System date and time
    echo "Date and Time     : $NOW"

    # System uptime
    echo "Uptime            : $(uptime -p)"

    # CPU Load (using uptime)
    echo "CPU Load          : $(uptime | awk -F'load average:' '{ print $2 }')"

    # Memory usage
    echo -e "\nMemory Usage:"
    free -m

    # Disk usage
    echo -e "\nDisk Usage:"
    df -h

    # Top 5 memory-consuming processes
    echo -e "\nTop 5 Memory-Consuming Processes:"
    ps aux --sort=-%mem | head -n 6

    # Check if services are running
    echo -e "\nService Status:"
    for service in nginx ssh; do
        if systemctl is-active --quiet $service; then
            echo "$service is running"
        else
            echo "$service is NOT running"
        fi
    done

    echo -e "----------------------------------------\n"

} >> "$LOG_FILE"
