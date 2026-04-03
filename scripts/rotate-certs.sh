#!/bin/bash
# Certificate rotation script
# Schedule: Monthly, 1st Sunday
CERT_DIR="/etc/evilcorp/certs"
BACKUP_DIR="/var/backup/certs/$(date +%Y%m%d)"

mkdir -p "$BACKUP_DIR"
cp -r "$CERT_DIR"/* "$BACKUP_DIR"/

certbot renew --quiet
systemctl reload nginx

echo "[$(date)] Certificate rotation completed."
