#!/bin/bash

# Script by t.me/@zetaxbyte
# Fix e2fsprogs and mke2fs issues

# Colors for output
YELLOW='\033[93m'
GREEN='\033[92m'
NC='\033[0m' # No color

echo -e "\n${YELLOW}Fixing mke2fs: Invalid filesystem option errors...${NC}\n"
sleep 0.5

echo -e "\n${GREEN}Removing e2fsprogs and mke2fs...${NC}\n"
sudo apt-get purge -y e2fsprogs
sleep 0.5
sudo rm -f /usr/sbin/mke2fs
sleep 0.5

# Clear shell hash table
hash -r

echo -e "\n${GREEN}Installing dependencies for e2fsprogs build...${NC}\n"
sudo apt update
sudo apt install -y build-essential libblkid-dev uuid-dev libuuid1

# Define e2fsprogs version
E2FSPROGS_VERSION="1.46.5"
E2FSPROGS_TARBALL="e2fsprogs_${E2FSPROGS_VERSION}.orig.tar.gz"
E2FSPROGS_URL="http://mirrors.kernel.org/ubuntu/pool/main/e/e2fsprogs/${E2FSPROGS_TARBALL}"

echo -e "\n${GREEN}Downloading e2fsprogs version ${E2FSPROGS_VERSION}...${NC}\n"
wget "${E2FSPROGS_URL}"
sleep 0.5

echo -e "\n${GREEN}Extracting and building e2fsprogs...${NC}\n"
tar -xvzf "${E2FSPROGS_TARBALL}"
cd "e2fsprogs-${E2FSPROGS_VERSION}"
./configure
sudo make
sudo make install
sleep 1
cd ..

# Cleanup
echo -e "\n${GREEN}Cleaning up...${NC}\n"
sudo rm -f "${E2FSPROGS_TARBALL}"
sudo rm -rf "e2fsprogs-${E2FSPROGS_VERSION}"

echo -e "\n${GREEN}e2fsprogs and mke2fs setup complete.${NC}\n"

# Optional: Install lolcat for fancy output
sudo apt install -y lolcat

echo -e "\n========== crave is wonderfully amazing ==========\n" | lolcat