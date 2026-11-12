#!/bin/bash

cat /etc/hosts | while read -r ip name; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue
    [[ -z "$name" ]] && continue

    ipn=$(nslookup "$name" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n 1)

    if [[ -n "$ipn" && "$ipn" != "$ip" ]]; then
        echo "Bogus IP for $name in /etc/hosts!"
    fi
done
