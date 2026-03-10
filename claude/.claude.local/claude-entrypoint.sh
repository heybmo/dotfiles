#!/bin/bash
set -euo pipefail

# Entrypoint script for secure Claude CLI container
# Handles conditional firewall initialization

log_msg() {
    echo "[$(date)] ENTRYPOINT: $1"
    logger -t "claude-entrypoint" "$1" 2>/dev/null || true
}

log_msg "Starting Claude CLI container"

# Check if we should initialize firewall
if [ "${ENABLE_FIREWALL:-true}" = "true" ]; then
    log_msg "Firewall enabled - checking capabilities"

    # Check if we have required capabilities
    if [ ! -f /proc/sys/net/netfilter/nf_conntrack_max ]; then
        log_msg "ERROR: NET_ADMIN capability required for firewall"
        log_msg "Run with: docker run --cap-add=NET_ADMIN --cap-add=NET_RAW"
        exit 1
    fi

    # Check if firewall already initialized
    if [ -f ~/.firewall-initialized ]; then
        log_msg "Firewall already initialized, skipping"
    else
        # Check if we're running as root (required for iptables)
        if [ "$(id -u)" != "0" ]; then
            log_msg "Switching to root for firewall initialization"
            # Re-exec as root with firewall setup, then drop to claude user
            exec sudo -E /usr/local/bin/claude-entrypoint.sh "$@";
        fi

        log_msg "Initializing firewall as root"
        /usr/local/bin/init-claude-firewall.sh
        touch ~/.firewall-initialized
    fi

    log_msg "Firewall initialization complete - dropping to user claude"
    log_msg "Command args: $*"
    log_msg "Number of args: $#"
    if [ $# -eq 0 ]; then
        log_msg "No command provided, using /bin/bash"
        exec su-exec claude:claude /bin/bash
    else
        exec su-exec claude:claude "$@"
    fi
else
    log_msg "Firewall disabled - bypassing setup"

    # If we're root, drop to claude user
    if [ "$(id -u)" = "0" ]; then
        exec su-exec claude:claude "$@"
    fi

    # Otherwise start directly (already claude user)
    exec "$@"
fi