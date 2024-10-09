#!/bin/bash

# Exit script on error
set -e

# Default values for ROM manifest, branch, device name, ROM name, build type, and remove prebuilts flag
ROM_MANIFEST_URL=${1:-"https://github.com/LineageOS/android.git"}
ROM_BRANCH=${2:-"lineage-18.0"}
DEVICE_NAME=${3:-"Z01K"}
ROM_NAME=${4:-"lineage"}
BUILD_TYPE=${5:-"userdebug"}
REMOVE_PREBUILTS=${6:-"yes"}  # Accept 'yes' or 'no' to remove prebuilts

# Start ROM build process
echo "Starting ROM build for device: $DEVICE_NAME with ROM: $ROM_NAME on branch: $ROM_BRANCH"

# Remove prebuilts if the flag is set to 'yes'
if [[ "$REMOVE_PREBUILTS" == "yes" ]]; then
    echo "Removing prebuilts directory..."
    rm -rf prebuilts
else
    echo "Skipping removal of prebuilts directory."
fi

# Initialize repo with ROM manifest and branch
echo "Initializing repo..."
repo init -u "$ROM_MANIFEST_URL" -b "$ROM_BRANCH" --git-lfs

# Remove and recreate local manifests directory
echo "Setting up local manifests..."
rm -rf .repo/local_manifests
mkdir -p .repo/local_manifests

# Copy roomservice.xml to local manifests
cp scripts/roomservice.xml .repo/local_manifests/

# Run resync script to sync repositories
echo "Running resync script..."
/opt/crave/resync.sh

# Set up the build environment and lunch for the target device
echo "Setting up build environment..."
source build/envsetup.sh
lunch "${DEVICE_NAME}-${BUILD_TYPE}"

# Build the ROM
echo "Building ROM..."
make -j$(nproc) bacon

# Pull the built ROM zip file using crave
BUILT_ROM_PATH="out/target/product/${DEVICE_NAME}/${ROM_NAME}*.zip"
echo "Pulling built ROM from $BUILT_ROM_PATH..."
crave pull "$BUILT_ROM_PATH"

# Check if pulling ROM was successful
if [ $? -eq 0 ]; then
    echo "ROM pulled successfully!"
else
    echo "Failed to pull ROM zip file."
    exit 1
fi
