#!/bin/bash
set -euo pipefail  # Exit on error, undefined vars, and pipeline failures
IFS=$'\n\t'       # Stricter word splitting

# Logging function for audit trails
log_action() {
    logger -t "firewall-init" "$1"
    echo "[$(date)] $1"
}

# Rate limiting for DNS queries
DNS_QUERY_DELAY=0.1  # 100ms between queries

log_action "Starting firewall initialization"

# 1. Extract Docker DNS info BEFORE any flushing
DOCKER_DNS_RULES=$(iptables-save -t nat | grep "127\.0\.0\.11" || true)
DOCKER_DNS6_RULES=$(ip6tables-save -t nat | grep "::1" || true)

# Flush existing rules and delete existing ipsets
log_action "Flushing existing firewall rules"
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# IPv6 firewall flush
ip6tables -F 2>/dev/null || true
ip6tables -X 2>/dev/null || true
ip6tables -t nat -F 2>/dev/null || true
ip6tables -t nat -X 2>/dev/null || true
ip6tables -t mangle -F 2>/dev/null || true
ip6tables -t mangle -X 2>/dev/null || true

ipset destroy allowed-domains 2>/dev/null || true
ipset destroy allowed-domains-v6 2>/dev/null || true

# 2. Selectively restore ONLY internal Docker DNS resolution
if [ -n "$DOCKER_DNS_RULES" ]; then
    log_action "Restoring Docker IPv4 DNS rules"
    iptables -t nat -N DOCKER_OUTPUT 2>/dev/null || true
    iptables -t nat -N DOCKER_POSTROUTING 2>/dev/null || true
    echo "$DOCKER_DNS_RULES" | xargs -L 1 iptables -t nat
else
    log_action "No Docker IPv4 DNS rules to restore"
fi

if [ -n "$DOCKER_DNS6_RULES" ]; then
    log_action "Restoring Docker IPv6 DNS rules"
    ip6tables -t nat -N DOCKER_OUTPUT 2>/dev/null || true
    ip6tables -t nat -N DOCKER_POSTROUTING 2>/dev/null || true
    echo "$DOCKER_DNS6_RULES" | xargs -L 1 ip6tables -t nat 2>/dev/null || true
else
    log_action "No Docker IPv6 DNS rules to restore"
fi

# First allow DNS and localhost before any restrictions
log_action "Setting up basic IPv4/IPv6 network access"

# Allow outbound DNS (IPv4 and IPv6)
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
ip6tables -A OUTPUT -p udp --dport 53 -j ACCEPT 2>/dev/null || true
ip6tables -A INPUT -p udp --sport 53 -j ACCEPT 2>/dev/null || true

# Allow outbound SSH (IPv4 and IPv6)
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -p tcp --dport 22 -j ACCEPT 2>/dev/null || true
ip6tables -A INPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT 2>/dev/null || true

# Allow localhost (IPv4 and IPv6)
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
ip6tables -A INPUT -i lo -j ACCEPT 2>/dev/null || true
ip6tables -A OUTPUT -o lo -j ACCEPT 2>/dev/null || true

# Create ipsets with CIDR support (IPv4 and IPv6)
log_action "Creating IP allowlists"
ipset create allowed-domains hash:net
ipset create allowed-domains-v6 hash:net family inet6

# Fetch GitHub meta information and aggregate + add their IP ranges
log_action "Fetching GitHub IP ranges"
gh_ranges=$(curl -s https://api.github.com/meta)
sleep $DNS_QUERY_DELAY
if [ -z "$gh_ranges" ]; then
    echo "ERROR: Failed to fetch GitHub IP ranges"
    exit 1
fi

if ! echo "$gh_ranges" | jq -e '.web and .api and .git' >/dev/null; then
    echo "ERROR: GitHub API response missing required fields"
    exit 1
fi

log_action "Processing GitHub IP ranges"
while read -r cidr; do
    if [[ "$cidr" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}$ ]]; then
        log_action "Adding GitHub IPv4 range: $cidr"
        ipset add allowed-domains "$cidr"
    elif [[ "$cidr" =~ ^[0-9a-fA-F:]+/[0-9]{1,3}$ ]]; then
        log_action "Adding GitHub IPv6 range: $cidr"
        ipset add allowed-domains-v6 "$cidr"
    else
        log_action "ERROR: Invalid CIDR range from GitHub meta: $cidr"
        exit 1
    fi
    sleep $DNS_QUERY_DELAY
done < <(echo "$gh_ranges" | jq -r '(.web + .api + .git)[]' | sort -u)

# Resolve and add other allowed domains (IPv4 and IPv6)
for domain in \
    "registry.npmjs.org" \
    "api.anthropic.com" \
    "sentry.io" \
    "statsig.anthropic.com" \
    "statsig.com" \
    "marketplace.visualstudio.com" \
    "vscode.blob.core.windows.net" \
    "update.code.visualstudio.com"; do

    log_action "Resolving $domain (IPv4)..."
    sleep $DNS_QUERY_DELAY
    ips=$(dig +noall +answer A "$domain" | awk '$4 == "A" {print $5}')
    if [ -z "$ips" ]; then
        log_action "WARNING: Failed to resolve IPv4 for $domain"
    else
        while read -r ip; do
            if [[ ! "$ip" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
                log_action "ERROR: Invalid IPv4 from DNS for $domain: $ip"
                exit 1
            fi
            log_action "Adding IPv4 $ip for $domain"
            ipset add allowed-domains "$ip"
        done < <(echo "$ips")
    fi

    log_action "Resolving $domain (IPv6)..."
    sleep $DNS_QUERY_DELAY
    ipv6s=$(dig +noall +answer AAAA "$domain" | awk '$4 == "AAAA" {print $5}')
    if [ -n "$ipv6s" ]; then
        while read -r ipv6; do
            if [[ ! "$ipv6" =~ ^[0-9a-fA-F:]+$ ]]; then
                log_action "ERROR: Invalid IPv6 from DNS for $domain: $ipv6"
                exit 1
            fi
            log_action "Adding IPv6 $ipv6 for $domain"
            ipset add allowed-domains-v6 "$ipv6"
        done < <(echo "$ipv6s")
    else
        log_action "No IPv6 records for $domain"
    fi
done

# Get host IP from default route (IPv4 and IPv6)
log_action "Detecting host networks"
HOST_IP=$(ip route | grep default | cut -d" " -f3)
if [ -z "$HOST_IP" ]; then
    log_action "ERROR: Failed to detect IPv4 host IP"
    exit 1
fi

HOST_NETWORK=$(echo "$HOST_IP" | sed "s/\.[0-9]*$/.0\/24/")
log_action "Host IPv4 network detected as: $HOST_NETWORK"

# Detect IPv6 host network
HOST_IPV6=$(ip -6 route | grep default | awk '{print $3}' | head -1) || true
if [ -n "$HOST_IPV6" ]; then
    HOST_NETWORK_V6=$(echo "$HOST_IPV6" | sed 's/:[0-9a-fA-F]*$/::/64/')
    log_action "Host IPv6 network detected as: $HOST_NETWORK_V6"
else
    log_action "No IPv6 default route found"
fi

# Set up remaining iptables rules (IPv4 and IPv6)
log_action "Configuring host network access"
iptables -A INPUT -s "$HOST_NETWORK" -j ACCEPT
iptables -A OUTPUT -d "$HOST_NETWORK" -j ACCEPT

if [ -n "$HOST_IPV6" ]; then
    ip6tables -A INPUT -s "$HOST_NETWORK_V6" -j ACCEPT
    ip6tables -A OUTPUT -d "$HOST_NETWORK_V6" -j ACCEPT
fi

# Set default policies to DROP first (IPv4 and IPv6)
log_action "Setting restrictive default policies"
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

ip6tables -P INPUT DROP 2>/dev/null || true
ip6tables -P FORWARD DROP 2>/dev/null || true
ip6tables -P OUTPUT DROP 2>/dev/null || true

# First allow established connections for already approved traffic
log_action "Configuring stateful connection tracking"
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
ip6tables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT 2>/dev/null || true
ip6tables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT 2>/dev/null || true

# Then allow only specific outbound traffic to allowed domains
log_action "Applying IP allowlists"
iptables -A OUTPUT -m set --match-set allowed-domains dst -j ACCEPT
ip6tables -A OUTPUT -m set --match-set allowed-domains-v6 dst -j ACCEPT 2>/dev/null || true

# Explicitly REJECT all other outbound traffic for immediate feedback
iptables -A OUTPUT -j REJECT --reject-with icmp-admin-prohibited
ip6tables -A OUTPUT -j REJECT --reject-with icmp6-adm-prohibited 2>/dev/null || true

log_action "Firewall configuration complete"
log_action "Verifying firewall rules..."

# Rate-limited verification tests
if curl --connect-timeout 5 https://example.com >/dev/null 2>&1; then
    log_action "ERROR: Firewall verification failed - was able to reach https://example.com"
    exit 1
else
    log_action "Firewall verification passed - unable to reach https://example.com as expected"
fi

sleep $DNS_QUERY_DELAY

# Verify GitHub API access
if ! curl --connect-timeout 5 https://api.github.com/zen >/dev/null 2>&1; then
    log_action "ERROR: Firewall verification failed - unable to reach https://api.github.com"
    exit 1
else
    log_action "Firewall verification passed - able to reach https://api.github.com as expected"
fi

log_action "Firewall initialization completed successfully"