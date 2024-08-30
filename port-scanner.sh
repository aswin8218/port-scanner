#!/bin/bash

# Function to get IP address from a repository URL
get_ip() {
    ip=$(curl -s https://api.github.com/repos/$1 | jq -r '.ssh_url_template' | sed 's/git@github.com:///')
    echo "$ip"
}

# Get repository URL from user
read -p "Enter the GitHub repository URL: " repo_url

# Get IP address from the URL
ip=$(get_ip $repo_url)

# Port range to scan
start_port=1
end_port=1024

# Scan ports
echo "Scanning ports for $ip:"
for port in $(seq $start_port $end_port); do
    if nc -z $ip $port > /dev/null 2>&1; then
        echo "Port $port is open"
    fi
done