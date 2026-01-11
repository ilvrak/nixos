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

echo "Creating GPT partition table..."
parted "$DISK" -- mklabel gpt

echo "Creating EFI partition (1 GiB)..."
parted "$DISK" -- mkpart ESP fat32 1MiB 1025MiB
parted "$DISK" -- set 1 esp on

echo "Creating swap partition (4 GiB)..."
parted "$DISK" -- mkpart primary linux-swap 1025MiB 5121MiB

echo "Creating root partition (rest of the disk)..."
parted "$DISK" -- mkpart primary ext4 5121MiB 100%

echo "Formatting filesystems..."
mkfs.ext4 -L nixos-root ${DISK}p3
mkswap -L swap ${DISK}p2
mkfs.fat -F32 -n boot ${DISK}p1

echo "Mounting filesystems..."
mount ${DISK}p3 /mnt
mkdir -p /mnt/boot
mount ${DISK}p1 /mnt/boot
swapon ${DISK}p2

echo
echo "Done."
lsblk "$DISK"
echo "/mnt is ready for nixos-generate-config and nixos-install."
