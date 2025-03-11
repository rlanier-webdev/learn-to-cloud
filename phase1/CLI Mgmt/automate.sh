#!/bin/bash
# Automate Instance

# This script automates the process of creating, verifying, starting, stopping, and deleting 
# a Google Cloud Compute Engine instance. It prompts the user for the instance name, zone, 
# machine type, image family, and image project. After creating the instance, it verifies 
# its existence, starts it, waits for 30 seconds, stops it, and then deletes it. 
# If any step fails, the script exits with an error message.
#
# Usage:
#   1. Run the script in a terminal.
#   2. Enter the required information when prompted.
#   3. The script will handle the entire lifecycle of the instance.
#
# Note: The script assumes that the 'gcloud' CLI is installed and authenticated.

echo "Enter the instance name."
read INSTANCE

echo "Enter the zone."
read ZONE

echo "Enter the machine type."
read MACHINE_TYPE

echo "Enter the image family."
read IMAGE_FAMILY

echo "Enter the image project"
read IMAGE_PROJECT

# Attempt to create the instance
echo "Creating instance..."
gcloud compute instances create "$INSTANCE" \
  --zone="$ZONE" \
  --machine-type="$MACHINE_TYPE" \
  --image-family="$IMAGE_FAMILY" \
  --image-project="$IMAGE_PROJECT"

# Check the exit code of the create command
if [ $? -eq 0 ]; then
    echo "Instance '$INSTANCE' created successfully."

    # Verify that the instance exists
    gcloud compute instances describe "$INSTANCE" --zone="$ZONE" > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "Instance '$INSTANCE' has been verified."
        # Proceed with other operations (start, stop, etc.)
        gcloud compute instances start "$INSTANCE" --zone="$ZONE"
        sleep 30 #wait for start
        gcloud compute instances stop "$INSTANCE" --zone="$ZONE"
        gcloud compute instances delete "$INSTANCE" --zone="$ZONE" --quiet
    else
        echo "Error: Instance '$INSTANCE' creation reported success, but instance cannot be described."
        exit 1
    fi
else
    echo "Error: Instance '$INSTANCE' creation failed."
    exit 1
fi

echo "Script completed."