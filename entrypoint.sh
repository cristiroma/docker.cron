#!/bin/bash
set -e

# Generate environment for CRON jobs
IFS='|' read -ra LENV <<< "$CRON_ENV"
for var in "${LENV[@]}"; do
	echo "export ${var}=\"${!var}\"" >> /usr/local/bin/cron-env.sh
done;

# Read CRON jobs from CRON_JOB* environment variables
job_num=0
for var in `compgen -A variable | grep CRON_JOB`; do
	job_num=$(expr $job_num + 1)
	echo "Installing job: ${var} in /etc/cron.d/${var}"
	echo "${!var}  >> /var/log/cron.log 2>&1"  > /etc/cron.d/${var}
done;

# Check count of installed jobs and issue warning
if [ "$job_num" -eq "0" ]; then
	echo "[WARNING] No CRON jobs! Declare via CRON_JOB* environment variables!"
else
	echo "${job_num} CRON jobs installed ..."
fi

# Start CRON in background
/usr/sbin/cron -L /var/log/cron.log

# Output CRON logs
tail -f /var/log/cron.log & wait $!
