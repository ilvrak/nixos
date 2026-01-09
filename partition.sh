#!/usr/bin/env bash
set -euo pipefail

DISK="/dev/nvme0n1"

echo "WARNING: ALL DATA ON $DISK WILL BE ERASED!"
read -p "Continue? (yes/NO): " ANSWER
if [ "$ANSWER" != "yes" ]; then
  echo "Aborted."
  exit 1
fi

echo "Wiping existing partition table and signatures..."
wipefs -af "$DISK"

echo "Creating GPT and partitions..."
parted "$DISK" -- mklabel gpt
parted "$DISK" -- mkpart ESP fat32 1MiB 513MiB
parted "$DISK" -- set 1 esp on
parted "$DISK" -- mkpart primary ext4 513MiB 100.5GiB
parted "$DISK" -- mkpart primary linux-swap 100.5GiB 116.5GiB
parted "$DISK" -- mkpart primary ext4 116.5GiB 100%

echo "Formatting filesystems..."
mkfs.fat -F32 -n NIXOS_BOOT ${DISK}p1
mkfs.ext4 -L NIXOS_ROOT ${DISK}p2
mkswap -L NIXOS_SWAP ${DISK}p3
mkfs.ext4 -L NIXOS_HOME ${DISK}p4

echo "Mounting filesystems..."
mount ${DISK}p2 /mnt
mkdir -p /mnt/boot /mnt/home
mount ${DISK}p1 /mnt/boot
mount ${DISK}p4 /mnt/home
swapon ${DISK}p3

echo "Done. /mnt is ready for nixos-generate-config and nixos-install."
