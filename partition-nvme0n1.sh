#!/usr/bin/env bash
set -euo pipefail

DISK="/dev/nvme0n1"

echo "!!! ВНИМАНИЕ: ВСЕ ДАННЫЕ НА $DISK БУДУТ УДАЛЕНЫ !!!"
read -p "Продолжить? (yes/NO): " ANSWER
if [ "$ANSWER" != "yes" ]; then
  echo "Отмена."
  exit 1
fi

echo "Стираю старую разметку..."
wipefs -af "$DISK"

echo "Создаю GPT и разделы..."
parted "$DISK" -- mklabel gpt
parted "$DISK" -- mkpart ESP fat32 1MiB 513MiB
parted "$DISK" -- set 1 esp on
parted "$DISK" -- mkpart primary ext4 513MiB 100.5GiB
parted "$DISK" -- mkpart primary linux-swap 100.5GiB 116.5GiB
parted "$DISK" -- mkpart primary ext4 116.5GiB 100%

echo "Форматирую файловые системы..."
mkfs.fat -F32 -n NIXOS_BOOT ${DISK}p1
mkfs.ext4 -L NIXOS_ROOT ${DISK}p2
mkswap -L NIXOS_SWAP ${DISK}p3
mkfs.ext4 -L NIXOS_HOME ${DISK}p4

echo "Монтирую..."
mount ${DISK}p2 /mnt
mkdir -p /mnt/boot /mnt/home
mount ${DISK}p1 /mnt/boot
mount ${DISK}p4 /mnt/home
swapon ${DISK}p3

echo "Готово. /mnt готов для nixos-generate-config и nixos-install."
