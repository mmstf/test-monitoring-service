#!/bin/bash

set -exu

PROCESS_NAME="test"
LOG_FILE="./monitoring.log"
MONITORING_URL="https://test.com/monitoring/test/api"

# check Log file exists
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# check is proccess running
is_process_running() {
  pgrep -x "$PROCESS_NAME" > /dev/null 2>&1
  return $?
}

# request to monitoring service
send_monitoring_request() {
  http_code=$(curl -s -o /dev/null -w "%{http_code}" "$MONITORING_URL")

  echo $http_code
  if [ "$http_code" -ne 200 ]; then
    echo "$(date) - Monitoring server is unavailable (HTTP code: $http_code)" >> "$LOG_FILE"
  fi
}

# check was process started before
if tail -n 1 "$LOG_FILE" | grep -q "Process $PROCESS_NAME is started"; then
  last_run_status=0
else
  last_run_status=1
fi

# check if process is running now
if is_process_running; then
  echo "$(date) - Process $PROCESS_NAME is started"

  # logging restart
  if [ "$last_run_status" -ne 0 ]; then
    echo "$(date) - Process $PROCESS_NAME was restarted" >> "$LOG_FILE"
  fi

  send_monitoring_request
else
  echo "$(date) - Process $PROCESS_NAME is not started yet"
fi

exit 0
