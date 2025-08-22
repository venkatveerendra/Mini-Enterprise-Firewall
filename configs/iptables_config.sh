#!/bin/bash
# Mini-Enterprise Firewall Setup - Linux iptables Config
# Author: Ch Veerendra

# Flush old rules
iptables -F
iptables -X
iptables -Z

# Default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT

# Allow HTTP/HTTPS to Web Server (DMZ)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow Web Server → Database (MySQL 3306)
iptables -A FORWARD -s 192.168.1.10 -d 192.168.2.10 -p tcp --dport 3306 -j ACCEPT

# Allow Admin LAN → Firewall SSH
iptables -A INPUT -s 192.168.3.0/24 -p tcp --dport 22 -j ACCEPT

# Log dropped packets (optional)
iptables -A INPUT -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
iptables -A FORWARD -j LOG --log-prefix "IPTables-Dropped: " --log-level 4

echo "Firewall rules applied successfully!"
