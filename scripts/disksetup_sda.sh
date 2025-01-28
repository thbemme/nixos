#!/run/current-system/sw/bin/sh
	DISK=/dev/sda
# Create partitions
printf "label: gpt\n,550M,U\n,,L\n" | sfdisk "$DISK"
# Format the EFI partition
mkfs.vfat -n BOOT "$DISK"1

# Setup encryption
cryptsetup --verify-passphrase -v luksFormat "$DISK"2
cryptsetup open "$DISK"2 rootfs

# Create rootfs
mkfs.btrfs /dev/mapper/rootfs

# Then create subvolumes
mount -t btrfs /dev/mapper/rootfs /mnt

# We first create the subvolumes outlined above:
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix

umount /mnt

# Mount the directories
mount -o subvol=root,compress=zstd,noatime /dev/mapper/rootfs /mnt

mkdir /mnt/{home,nix}
mount -o subvol=home,compress=zstd,noatime /dev/mapper/rootfs /mnt/home
mount -o subvol=nix,compress=zstd,noatime /dev/mapper/rootfs /mnt/nix

# don't forget this!
mkdir /mnt/boot
mount "$DISK"1 /mnt/boot

echo 'git clone https://git.kbnetcloud.de/user/nixos.git'
echo 'sudo nixos-generate-config --root /mnt --show-hardware-config > hosts/<host>/hardware-configuration.nix'
echo 'sudo nixos-install --flake /home/nixos/nixos#default --no-root-password'
echo 'sudo nixos-enter --root /mnt -c "passwd <user>"'
