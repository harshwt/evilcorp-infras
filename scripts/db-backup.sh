#!/bin/bash
# PostgreSQL backup to S3
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="evilcorp_prod_${TIMESTAMP}.sql.gz"

pg_dump -h postgres.internal.evilcorp.local -U admin evilcorp_prod | gzip > "/tmp/$BACKUP_FILE"
aws s3 cp "/tmp/$BACKUP_FILE" "s3://evilcorp-backups/postgres/$BACKUP_FILE"
rm "/tmp/$BACKUP_FILE"

echo "[$(date)] Backup $BACKUP_FILE uploaded to S3."
