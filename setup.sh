#!/bin/bash

# Ensure required packages are installed
sudo apt-get update
sudo apt-get install -y curl jq

# Function to configure integrations
configure_integrations() {
  INTEGRATION_CONFIG_FILE="configs/integration_config.json"

  if [ ! -f "$INTEGRATION_CONFIG_FILE" ]; then
    echo "Integration configuration file not found!"
    exit 1
  fi

  SALESFORCE_API_URL=$(jq -r '.salesforce.api_url' "$INTEGRATION_CONFIG_FILE")
  TRUECOMMERCE_API_URL=$(jq -r '.truecommerce.api_url' "$INTEGRATION_CONFIG_FILE")
  JITTERBIT_API_URL=$(jq -r '.jitterbit.api_url' "$INTEGRATION_CONFIG_FILE")
  CLOUD4J_API_URL=$(jq -r '.cloud4j.api_url' "$INTEGRATION_CONFIG_FILE")
  QUICKBOOKS_API_URL=$(jq -r '.quickbooks.api_url' "$INTEGRATION_CONFIG_FILE")

  echo "Configuring integrations..."
  curl -X POST -H "Content-Type: application/json" -d @"$INTEGRATION_CONFIG_FILE" "$SALESFORCE_API_URL"
  curl -X POST -H "Content-Type: application/json" -d @"$INTEGRATION_CONFIG_FILE" "$TRUECOMMERCE_API_URL"
  curl -X POST -H "Content-Type: application/json" -d @"$INTEGRATION_CONFIG_FILE" "$JITTERBIT_API_URL"
  curl -X POST -H "Content-Type: application/json" -d @"$INTEGRATION_CONFIG_FILE" "$CLOUD4J_API_URL"
  curl -X POST -H "Content-Type: application/json" -d @"$INTEGRATION_CONFIG_FILE" "$QUICKBOOKS_API_URL"

  echo "Integrations configured successfully!"
}

# Call the function to configure integrations
configure_integrations
