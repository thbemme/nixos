{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/amdgpu.nix
    ../../modules/hardware/led.nix
    ../../modules/hardware/msib450mpro.nix
    ../../modules/profiles/default.nix
    ../../modules/profiles/desktop-extras.nix
    #../../modules/profiles/desktop-gnome.nix
    ../../modules/profiles/desktop-minimal.nix
    ../../modules/profiles/desktop-niri.nix
    ../../modules/profiles/dev.nix
    ../../modules/profiles/gaming.nix
    ../../modules/profiles/home.nix
    ../../modules/profiles/security.nix
    ../../modules/profiles/work.nix
    #../../modules/services/llm.nix
    ../../modules/services/printing.nix
    ../../modules/services/prometheus.nix
    ../../modules/services/smart.nix
    ../../modules/services/ssh.nix
    ../../modules/services/virt.nix
    ../../modules/system/btrfs.nix
    ../../modules/system/hibernate.nix
    ../../modules/system/hosts.nix
    ../../modules/system/kernel-desktop.nix
    ../../modules/system/plymouth.nix
    ../../modules/system/secureboot.nix
  ];

  networking.hostName = "puffy"; # Define your hostname.

  services.xserver.videoDrivers = ["amdgpu"];

  # Enable nct6775 module for sensor readings
  boot.kernelModules = ["nct6775"];

  # Enable firmware service
  services.fwupd.enable = true;
}
