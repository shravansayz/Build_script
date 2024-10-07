# Custom ROM Build Script

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

1. Clone this repository to your local machine:

   ```bash
   git clone <your-repo-url>
   cd <your-repo-directory>
   
2.
  ```bash
     chmod +x build_rom.sh

3.
   ```bash
   ../build.sh
