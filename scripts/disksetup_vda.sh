#!/run/current-system/sw/bin/sh
	DISK=/dev/vda
# Create partitions
printf "label: gpt\n,550M,U\n,,L\n" | sfdisk "$DISK"
# Format the EFI partition
mkfs.vfat -n BOOT "$DISK"1

# Creat the swap inside the encrypted partition
mkfs.btrfs "$DISK"2

# Then create subvolumes

mount -t btrfs "$DISK"2 /mnt

# We first create the subvolumes outlined above:
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix

umount /mnt

# Mount the directories

mount -o subvol=root,compress=zstd,noatime "$DISK"2 /mnt

mkdir /mnt/{home,nix}
mount -o subvol=home,compress=zstd,noatime "$DISK"2 /mnt/home
mount -o subvol=nix,compress=zstd,noatime "$DISK"2 /mnt/nix

# don't forget this!
mkdir /mnt/boot
mount "$DISK"1 /mnt/boot

echo git clone https://git.kbnetcloud.de/user/nixos.git
echo sudo nixos-generate-config --root /mnt --show-hardware-config > hosts/<host>/hardware-configuration.nix
echo sudo nixos-install --flake /home/nixos/nixos#default --no-root-password
echo sudo nixos-enter --root /mnt -c 'passwd user'
