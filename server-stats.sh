#!/bin/bash

# Function to get total CPU usage
get_cpu_usage() {
    echo "🔹 CPU Usage:"
    top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'
}

# Function to get memory usage
get_memory_usage() {
    echo -e "\n🔹 Memory Usage:"
    free -m | awk 'NR==2{printf "Used: %sMB / %sMB (%.2f%%)\n", $3, $2, $3*100/$2}'
}

# Function to get disk usage
get_disk_usage() {
    echo -e "\n🔹 Disk Usage:"
    df -h | awk '$NF=="/"{printf "Used: %s / %s (%s)\n", $3, $2, $5}'
}

# Function to get top 5 CPU-consuming processes
get_top_cpu_processes() {
    echo -e "\n🔹 Top 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6
}

# Function to get top 5 memory-consuming processes
get_top_memory_processes() {
    echo -e "\n🔹 Top 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -6
}

# Extra system info
get_extra_stats() {
    echo -e "\n🔹 Extra System Stats:"
    echo "OS Version: $(lsb_release -d | cut -f2-)"
    echo "Uptime: $(uptime -p)"
    echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
    echo "Logged-in Users: $(who | wc -l)"
    echo "Failed Login Attempts: $(grep "Failed password" /var/log/auth.log | wc -l)"
}

# Run all functions
get_cpu_usage
get_memory_usage
get_disk_usage
get_top_cpu_processes
get_top_memory_processes
get_extra_stats
