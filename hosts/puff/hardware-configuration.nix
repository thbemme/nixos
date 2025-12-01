{
  inputs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  # Boot configuration
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod"];
      kernelModules = [];
      luks.devices."rootfs" = {
        device = "/dev/disk/by-partlabel/root";
        bypassWorkqueues = true; # Improve SSD performance
        allowDiscards = true; # Enable fstrim (note: potential info leak)
      };
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
    resumeDevice = "/dev/disk/by-label/rootfs";
    kernelParams = ["resume_offset=93038216"]; # btrfs inspect-internal map-swapfile -r /var/lib/swapfile
  };

  # Filesystem configuration
  fileSystems = {
    "/" = {
      label = "rootfs";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd" "noatime"];
    };
    "/home" = {
      label = "rootfs";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd" "noatime"];
    };
    "/nix" = {
      label = "rootfs";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime"];
    };
    "/boot" = {
      label = "boot";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  # Swap configuration for hibernation
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 12 * 1024; # 12 GiB swap file
    }
  ];

  # Networking
  networking.useDHCP = lib.mkDefault true;

  # Platform
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
