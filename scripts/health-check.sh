#!/bin/bash
# Cluster health check - runs every 5 min via cron
ENDPOINTS=("https://api.internal:8443/health" "https://web:443/ping")

for ep in "${ENDPOINTS[@]}"; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "$ep")
    if [ "$status" != "200" ]; then
        echo "[ALERT] $ep returned $status" | mail -s "Health Check Failed" ops@evilcorp.local
    fi
done
echo "[$(date)] Health check completed."
