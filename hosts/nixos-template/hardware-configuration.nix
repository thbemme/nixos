{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  # Boot configuration for QEMU guest
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "xhci_pci"
        "virtio_pci"
        "sr_mod"
        "virtio_blk"
      ];
      kernelModules = [];
    };
    extraModulePackages = [];
    kernelParams = [
      "console=tty1"
      "console=ttyS0,115200" # Serial console for debugging
    ];
  };

  # Filesystem configuration (Btrfs with zstd compression)
  fileSystems = {
    "/" = {
      label = "rootfs";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd"];
    };
    "/home" = {
      label = "rootfs";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd"];
    };
    "/nix" = {
      label = "rootfs";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd"];
    };
  };

  # No swap devices (adjust if needed)
  swapDevices = [];

  # Networking (DHCP enabled by default)
  networking.useDHCP = lib.mkDefault true;

  # Platform
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
