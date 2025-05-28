#!/run/current-system/sw/bin/sh
	DISK=/dev/sda
# Create partitions
printf "label: gpt\n,550M,U,name=efi\n,,L,name=root\n" | sfdisk "$DISK"
# Format the EFI partition
mkfs.vfat -n boot "$DISK"1

# Setup encryption
cryptsetup --verify-passphrase -v luksFormat /dev/disk/by-partlabel/root
cryptsetup open /dev/disk/by-partlabel/root rootfs

# Create rootfs
mkfs.btrfs -L rootfs /dev/mapper/rootfs

# Then create subvolumes
mount -t btrfs -L rootfs /mnt

# We first create the subvolumes outlined above:
btrfs subvolume create /mnt/{root,home,nix}

umount /mnt

# Mount the directories
mount -o subvol=root,compress=zstd,noatime -L rootfs /mnt

mkdir /mnt/{home,nix}
mount -o subvol=home,compress=zstd,noatime -L rootfs /mnt/home
mount -o subvol=nix,compress=zstd,noatime -L rootfs /mnt/nix

# don't forget this!
mkdir /mnt/boot
mount -L boot /mnt/boot
