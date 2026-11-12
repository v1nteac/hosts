#!/bin/bash


verifica_dns() {
    local host="$1"
    local ip_asteptat="$2"
    local dns_server="$3"

    local ip_gasit
    ip_gasit=$(nslookup "$host" "$dns_server" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n 1)

    if [[ -n "$ip_gasit" && "$ip_gasit" != "$ip_asteptat" ]]; then
        echo "Bogus IP for $host in /etc/hosts! (DNS-ul $dns_server zice: $ip_gasit)"
    fi
}

DNS_SERVER="8.8.8.8"

cat /etc/hosts | while read -r ip name; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue
    [[ -z "$name" ]] && continue

    verifica_dns "$name" "$ip" "$DNS_SERVER"

done
