#!/bin/bash

# Function to exit script on error
set -e

# Variables for ROM manifest, branch, device name, ROM name, and build type
ROM_MANIFEST_URL=${1:-"https://github.com/LineageOS/android.git"}
ROM_BRANCH=${2:-"lineage-18.0"}
DEVICE_NAME=${3:-"Z01K"}  # Placeholder for device name
ROM_NAME=${4:-"lineage"}           # Placeholder for ROM name
BUILD_TYPE=${5:-"userdebug"}               # Default build type (user, userdebug, eng)
SCRIPTS_REPO_URL="https://github.com/foxartic/scripts.git"
SCRIPTS_BRANCH="main"

# Function to remove prebuilts if using an old ROM
remove_prebuilts_if_old() {
    OLD_ROM_BRANCHES=("lineage-17.1" "lineage-16.0" "lineage-15.1" "lineage-14.1" "lineage-18.0" "lineage-18.1")

    if [[ " ${OLD_ROM_BRANCHES[@]} " =~ " ${ROM_BRANCH} " ]]; then
        echo "Detected an old ROM branch ($ROM_BRANCH). Removing prebuilts folder..."
        rm -rf prebuilts
    else
        echo "ROM branch ($ROM_BRANCH) is not considered old. Skipping removal of prebuilts."
    fi
}

# Remove prebuilts if applicable
remove_prebuilts_if_old

# Clone scripts repository
echo "Cloning scripts repository..."
rm -rf scripts .repo/local_manifests/ && \
git clone "$SCRIPTS_REPO_URL" -b "$SCRIPTS_BRANCH"

# Initialize repo with user-specified or default ROM manifest and branch
echo "Initializing repo with ROM manifest: $ROM_MANIFEST_URL on branch: $ROM_BRANCH"
repo init -u "$ROM_MANIFEST_URL" -b "$ROM_BRANCH" --git-lfs

# Create local manifests directory
echo "Creating local manifests directory..."
mkdir -p .repo/local_manifests

# Copy roomservice.xml to local manifests
echo "Copying roomservice.xml..."
cp scripts/roomservice.xml .repo/local_manifests/

# Run /opt/crave/resync.sh before syncing repositories
echo "Running /opt/crave/resync.sh..."
/opt/crave/resync.sh

# Sync repositories
echo "Syncing repositories..."
repo sync -c -j$(nproc) --force-sync --no-clone-bundle --no-tags

# Set up the environment for building
echo "Setting up build environment for device: $DEVICE_NAME with ROM name: $ROM_NAME"
source build/envsetup.sh
lunch "${DEVICE_NAME}_${BUILD_TYPE}"

# Build the ROM
echo "Starting the ROM build..."
make -j$(nproc) bacon

# Use crave to pull the built ROM zip file from the output folder
BUILT_ROM_PATH="out/target/product/${DEVICE_NAME}/${ROM_NAME}*.zip"
echo "Pulling the built ROM .zip file using crave..."
crave pull "$BUILT_ROM_PATH"

# Check if crave pull was successful
if [ $? -eq 0 ]; then
    echo "Custom ROM pulled successfully!"
else
    echo "Failed to pull the ROM zip file."
    exit 1
fi
