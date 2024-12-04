import os
import time
import random
from flask import Flask, request, jsonify

app = Flask(__name__)

# Fetch external API keys from environment variables
EXTERNAL_API_ENV_KEYS = {
    "development": os.getenv("EXTERNAL_DEV_KEY", "default-dev-key"),
    "staging": os.getenv("EXTERNAL_STAGE_KEY", "default-stage-key"),
    "production": os.getenv("EXTERNAL_PROD_KEY", "default-prod-key")
}

def generate_log():
    logs = [
        "Success",
        "Created",
        "Failed",
    ]
    return random.choice(logs)

@app.route('/api_1')
def api_call():
    log_message = generate_log()
    print(f"Operation log: {log_message}")
    time.sleep(0.5)  # Wait for half a second
    return f"completed: {log_message}"

@app.route('/health_check')
def health_check():
    return "healthy"

@app.route('/download_external_logs', methods=['GET'])
def download_external_logs():

    env = request.args.get('env', 'development') 
    integration_key = EXTERNAL_API_ENV_KEYS.get(env)
    if not integration_key:
        return jsonify({"error": f"Invalid environment: {env}"}), 400
    print(f"Calling external API in {env} environment with key: {integration_key}")
    time.sleep(1)  # Simulate delay
    external_api_response = {
        "status": "success",
        "message": f"Logs downloaded for {env} environment",
        "env": env
    }
    return jsonify(external_api_response)

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)