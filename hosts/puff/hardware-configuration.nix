{
  config,
  inputs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  # Resume for hibernation
  boot.resumeDevice = "/dev/disk/by-uuid/79b39c5a-f3ed-44e7-80bb-e1707d417b5c";
  # sudo btrfs inspect-internal map-swapfile -r /var/lib/swapfile
  boot.kernelParams = ["resume_offset=23978470"];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/79b39c5a-f3ed-44e7-80bb-e1707d417b5c";
    fsType = "btrfs";
    options = ["subvol=root" "compress=zstd"];
  };

  boot.initrd.luks.devices."rootfs".device = "/dev/disk/by-uuid/56f1fdbf-22a4-4c99-bbea-42ef983e8d7b";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/79b39c5a-f3ed-44e7-80bb-e1707d417b5c";
    fsType = "btrfs";
    options = ["subvol=home" "compress=zstd"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/79b39c5a-f3ed-44e7-80bb-e1707d417b5c";
    fsType = "btrfs";
    options = ["subvol=nix" "compress=zstd"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D153-37BC";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  # Extra swap file for hibernation
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
