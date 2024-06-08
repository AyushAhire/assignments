#!/bin/bash

# Configurable variables
URL="https://github.com"
EXPECTED_STATUS_CODE=200
LOG_FILE="/home/anonymous/logs/uptime.log"
LOG_DIR=$(dirname $LOG_FILE)
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Ensure the log directory exists
mkdir -p $LOG_DIR

# Function to log messages
log_message() {
    local MESSAGE=$1
    echo "$TIMESTAMP: $MESSAGE" >> $LOG_FILE
}

# Function to check the application's status
check_status() {
    HTTP_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" $URL)
    return $HTTP_RESPONSE
}

# Check the status
check_status
HTTP_CODE=$?

# Log and print the result
if [ $HTTP_CODE -eq $EXPECTED_STATUS_CODE ]; then
    log_message "Application is UP. HTTP status code: $HTTP_CODE"
    echo -e "\033[0;32mApplication is UP. HTTP status code: $HTTP_CODE\033[0m"
else
    log_message "Application is DOWN. HTTP status code: $HTTP_CODE"
    echo -e "\033[0;31mApplication is DOWN. HTTP status code: $HTTP_CODE\033[0m"
fi

# Report the status
tail -n 10 $LOG_FILE
