#!/bin/bash

cleanup() {
    echo "Cleaning up..."
    kill $KUBECTL_PID
    exit
}

trap cleanup SIGINT SIGTERM

echo "Starting kubectl port-forward...\n"
kubectl port-forward services/backend-api 8080:80 &
KUBECTL_PID=$!

sleep 2

if ps -p $KUBECTL_PID > /dev/null; then
    echo "Port-forwarding is active. Running health checks...\n"
else
    echo "Failed to establish port-forwarding. Exiting.\n"
    exit 1
fi

while true; do
    echo "Checking service health...\n"
    http_response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health_check)
    if [ "$http_response" == "200" ]; then
        echo "$(date): API at $API_URL is reachable - Health check passed"
    else
        echo "$(date): API at $API_URL is unreachable - Health check failed (HTTP $http_response)"
    fi
    sleep 5
done