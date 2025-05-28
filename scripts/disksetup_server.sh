#!/run/current-system/sw/bin/sh
	DISK=/dev/vda
# Create partitions
printf "label: dos\n,,L\n" | sfdisk "$DISK"

# Create rootfs
mkfs.btrfs -l rootfs "$DISK"1

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
