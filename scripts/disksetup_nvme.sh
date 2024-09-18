#!/run/current-system/sw/bin/bash
DISK=/dev/nvme0n1
# Create partitions
printf "label: gpt\n,550M,U\n,,L\n" | sfdisk "$DISK"
# Format the EFI partition
mkfs.vfat -n BOOT "$DISK"p1

cryptsetup --verify-passphrase -v luksFormat "$DISK"p2
cryptsetup open "$DISK"p2 rootfs-nvme0n1

# Creat the swap inside the encrypted partition
mkfs.btrfs /dev/mapper/rootfs-nvme0n1

# Then create subvolumes

mount -t btrfs /dev/mapper/rootfs-nvme0n1 /mnt

# We first create the subvolumes outlined above:
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix

umount /mnt

# Mount the directories

mount -o subvol=root,compress=zstd,noatime /dev/mapper/rootfs-nvme0n1 /mnt

mkdir /mnt/{home,nix,media}
mount -o subvol=home,compress=zstd,noatime /dev/mapper/rootfs-nvme0n1 /mnt/home
mount -o subvol=nix,compress=zstd,noatime /dev/mapper/rootfs-nvme0n1 /mnt/nix
mount /dev/sda1 /mnt/media

# don't forget this!
mkdir /mnt/boot
mount "$DISK"p1 /mnt/boot

echo git clone https://git.kbnetcloud.de/user/nixos.git
echo sudo nixos-generate-config --root /mnt --show-hardware-config > hosts/<host>/hardware-configuration.nix
echo sudo nixos-install --flake /home/nixos/nixos#default --no-root-password
echo sudo nixos-enter --root /mnt -c 'passwd user'