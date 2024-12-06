#!/bin/bash

# Default sleep duration
SLEEP_DURATION=5

# Parse command-line arguments
while getopts "s:" opt; do
  case $opt in
    s)
      SLEEP_DURATION=$OPTARG
      # Validate the input to ensure it's a positive integer
      if ! [[ "$SLEEP_DURATION" =~ ^[0-9]+$ ]]; then
        echo "Invalid value for -s. Please enter a positive integer."
        exit 1
      fi
      ;;
    *)
      echo "Usage: $0 [-s sleep_duration]"
      exit 1
      ;;
  esac
done

API_URL=http://${BACKEND_API_SERVICE_HOST}/health_check

# Continuous health check loop
while true; do
    http_response=$(curl -s -o /dev/null -w "%{http_code}" "$API_URL")

    if [ "$http_response" == "200" ]; then
        echo "$(date): API at $API_URL is reachable - Health check passed"
    else
        echo "$(date): API at $API_URL is unreachable - Health check failed (HTTP $http_response)"
    fi

    # Sleep for the specified duration before the next iteration
    sleep "$SLEEP_DURATION"
done
