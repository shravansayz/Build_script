#!/bin/bash

# script by t.me/@zetaxbyte

# Mendefinisikan kode warna ANSI
normal="\033[0m"
merah="\033[38;5;196m"
orange="\033[38;5;202m"
kuning="\033[38;5;226m"
hijau="\033[38;5;46m"
cyan="\033[38;5;51m"
biru="\033[38;5;33m"
ungu="\033[38;5;93m"
putih="\033[38;5;15m"

# Menampilkan efek warna pelangi dengan transisi yang lebih halus
echo -e "\n$merah██ $orange██ $kuning██ $hijau██ $cyan██ $biru██ $ungu██ $putih██ $normal"
echo -e "$merah██ $orange██ $kuning██ $hijau██ $cyan██ $biru██ $ungu██ $putih██ $normal\n"

# fix e2fsprogs & mke2fs 
echo -e "\n\033[96mfix mke2fs Invalid filesystem option set: has_journal,extent,huge_file,flex_bg,metadata_csum,metadata_csum_seed,64bit,dir_nlink,extra_isize,orphan_file\033[0m\n"
sleep 0.5
echo -e "\n\033[93mget purge e2fsprogs and remove mke2fs\033[0m\n"

sudo apt-get purge e2fsprogs
sleep 0.5
sudo rm /usr/sbin/mke2fs
sleep 0.5

#remove cacche hash table shell
hash -r

#dependecny for e2fsprogs
echo -e "\n\033[92msetup dependecy build for e2fsprogs\033[0m\n"

sudo apt update
sudo apt install build-essential libblkid-dev uuid-dev libuuid1 -y

#wget e2fsprogs latests
wget http://mirrors.kernel.org/ubuntu/pool/main/e/e2fsprogs/e2fsprogs_1.46.5.orig.tar.gz
sleep 0.5
tar -xvzf e2fsprogs_1.46.5.orig.tar.gz
cd e2fsprogs-1.46.5
./configure
sudo make
sudo make install
sleep 1
cd ..
sudo rm e2fsprogs_1.46.5.orig.tar.gz
sudo rm -rf e2fsprogs-1.46.5/

echo -e "\n\033[92msetup e2fsprogs & mke2fs complete\033[0m\n"

echo -e "\n\033[96m==========crave is wonderfully amazing==========\033[0m\n"

# Menampilkan efek warna pelangi dengan transisi yang lebih halus
echo -e "\n$merah██ $orange██ $kuning██ $hijau██ $cyan██ $biru██ $ungu██ $putih██ $normal"
echo -e "$merah██ $orange██ $kuning██ $hijau██ $cyan██ $biru██ $ungu██ $putih██ $normal\n"