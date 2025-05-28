#!/run/current-system/sw/bin/bash
DISK=/dev/nvme0n1
# Create partitions
printf "label: gpt\n,550M,U,name=efi\n,,L,name=root\n" | sfdisk "$DISK"

# Format the EFI partition
mkfs.vfat -n boot "$DISK"p1

# Setup encryption
cryptsetup --verify-passphrase -v luksFormat /dev/disk/by-partlabel/root
cryptsetup open /dev/disk/by-partlabel/root rootfs-nvme0n1

# Create rootfs
mkfs.btrfs -L rootfs /dev/mapper/rootfs-nvme0n1

# Then create subvolumes
mount -t btrfs -L rootfs /mnt

# We first create the subvolumes outlined above:
btrfs subvolume create /mnt/{root,home,nix}

umount /mnt

# Mount the directories
mount -o subvol=root,compress=zstd,noatime -L rootfs /mnt

mkdir /mnt/{home,nix,media}
mount -o subvol=home,compress=zstd,noatime -L rootfs /mnt/home
mount -o subvol=nix,compress=zstd,noatime -L rootfs /mnt/nix

# don't forget this!
mkdir /mnt/boot
mount -L boot /mnt/boot

# Additional disk
mount -L media /media