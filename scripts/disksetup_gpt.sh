#!/usr/bin/env bash
# https://git.kbnetcloud.de/riza/nixos/src/branch/main/scripts/disksetup_gpt.sh
set -euo pipefail

# Default parameters
ROOT_PARTITION_LABEL="root"
BOOT_PARTITION_LABEL="boot"
ENCRYPT=true

# EFI partition size for all disk types
EFI_SIZE="1024M"

# Detect disk type
if ls /dev/nvme0n1 >/dev/null 2>&1; then
	DISK="/dev/nvme0n1"
	EFI_PARTITION="$DISK"p1
	ROOT_PARTITION="$DISK"p2
	MAPPER_NAME="rootfs-nvme0n1"
elif ls /dev/sda >/dev/null 2>&1; then
	DISK="/dev/sda"
	MAPPER_NAME="rootfs-sda"
	EFI_PARTITION="$DISK"1
	ROOT_PARTITION="$DISK"2
elif ls /dev/vda >/dev/null 2>&1; then
	DISK="/dev/vda"
	ENCRYPT=false
	EFI_PARTITION="$DISK"1
	ROOT_PARTITION="$DISK"2
else
	echo "No supported disk found (NVMe, SATA, or virtual)." >&2
	exit 1
fi

# Warn user and ask for confirmation
echo "WARNING: This script will ERASE ALL DATA on $DISK and set up a new filesystem."
read -rp "Are you sure you want to continue? [Yes/No] " confirm
if [ "$confirm" != "Yes" ]; then
	echo "Aborted by user."
	exit 1
fi

# Create partitions
printf "label: gpt\n,$EFI_SIZE,U\n,,L\n" | sfdisk "$DISK"
parted "$DISK" -- name 1 efi
parted "$DISK" -- name 2 "$ROOT_PARTITION_LABEL"

# Format the EFI partition
mkfs.vfat -In "$BOOT_PARTITION_LABEL" "$EFI_PARTITION"

# Setup encryption
if [ "$ENCRYPT" = true ]; then
	cryptsetup --verify-passphrase -v luksFormat "/dev/disk/by-partlabel/$ROOT_PARTITION_LABEL"
	cryptsetup open "/dev/disk/by-partlabel/$ROOT_PARTITION_LABEL" "$MAPPER_NAME"
	ROOTFS_DEVICE="/dev/mapper/$MAPPER_NAME"
else
	ROOTFS_DEVICE="$ROOT_PARTITION"
fi

# Create rootfs
mkfs.btrfs -fL rootfs "$ROOTFS_DEVICE"

# Create and mount subvolumes
mount -t btrfs -L rootfs /mnt
btrfs subvolume create /mnt/{root,home,nix}
umount /mnt

# Mount the directories
mount -o subvol=root,compress=zstd,noatime -L rootfs /mnt
mkdir -p /mnt/{home,nix}
mount -o subvol=home,compress=zstd,noatime -L rootfs /mnt/home
mount -o subvol=nix,compress=zstd,noatime -L rootfs /mnt/nix

# Mount boot
mkdir -p /mnt/boot
mount -L "$BOOT_PARTITION_LABEL" /mnt/boot

echo "Disk setup complete for $DISK."
