#!/bin/bash

# Define colors for output
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

# Function to print section header
print_header() {
  echo -e "${CYAN}-------------------------------------------------"
  echo -e "$1"
  echo -e "-------------------------------------------------${RESET}"
}

# Function to print usage
print_usage() {
  echo -e "${YELLOW}Usage: $0 /path/to/logfile${RESET}"
  exit 1
}

# Get log file path from arguments
LOG_FILE=$1

# Check if log file is provided
if [ -z "$LOG_FILE" ]; then
  print_usage
fi

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo -e "${YELLOW}Log file not found!${RESET}"
  exit 1
fi

# Begin analysis
echo -e "${GREEN}Analyzing log file: $LOG_FILE${RESET}"
echo -e "${CYAN}==============================================${RESET}"

# Number of 404 errors
print_header "Number of 404 errors:"
grep " 404 " $LOG_FILE | wc -l

# Most requested pages
print_header "Top 10 most requested pages:"
awk '{print $7}' $LOG_FILE | sort | uniq -c | sort -nr | head -10

# IP addresses with the most requests
print_header "Top 10 IP addresses with the most requests:"
awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | head -10

# Most common user agents
print_header "Top 10 most common user agents:"
awk -F\" '{print $6}' $LOG_FILE | sort | uniq -c | sort -nr | head -10

# HTTP status codes distribution
print_header "HTTP status codes distribution:"
awk '{print $9}' $LOG_FILE | grep '^[0-9][0-9][0-9]$' | sort | uniq -c | sort -nr

# Top 10 referrers
print_header "Top 10 referrers:"
awk -F\" '{print $4}' $LOG_FILE | sort | uniq -c | sort -nr | head -10

# Completion message
echo -e "${GREEN}Log analysis complete.${RESET}"
