{
  config,
  inputs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd-sea-islands
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  # Boot configuration
  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
      luks.devices."rootfs-nvme0n1" = {
        device = "/dev/disk/by-partlabel/root";
        bypassWorkqueues = true; # Improve SSD performance
        allowDiscards = true; # Enable fstrim (note: potential info leak)
      };
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
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
    "/media" = {
      label = "media";
      fsType = "btrfs";
      options = ["compress=zstd" "noatime"];
    };
  };

  swapDevices = [];

  # Networking
  networking.useDHCP = lib.mkDefault true;

  # Platform
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Hardware-specific settings
  hardware.amdgpu = {
    opencl.enable = true;
  };
}
