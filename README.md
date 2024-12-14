# Crave Custom ROM Build Script

This script automates the process of building a custom ROM from a specified Android source code repository. It allows you to specify the ROM manifest URL, branch, device name, ROM name, and build type. The built ROM can then be pulled for further use.

## Features

- Clone a scripts repository for additional utilities.
- Initialize a repo for the specified ROM manifest and branch.
- Remove old prebuilts if using legacy ROM branches.
- Sync the source repositories.
- Set up the build environment for the specified device.
- Build the custom ROM.
- Pull the built ROM ZIP file from the output directory.

## Prerequisites

- A Linux-based operating system.
- Necessary build dependencies for Android ROM building.
- Git, repo, and `crave` installed on your system.
- Sufficient disk space for the Android source code and built ROM.

## Usage

1. Use in crave :

   ```bash
    crave run --no-patch -- "rm -rf scripts && git clone https://github.com/Shravan55555/build_script.git && bash build_script/build.sh"
