{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/amdgpu.nix
    ../../modules/btrfs.nix
    ../../modules/cli.nix
    ../../modules/default.nix
    ../../modules/desktop-kernel.nix
    ../../modules/dev.nix
    ../../modules/gaming.nix
    ../../modules/gnome.nix
    #../../modules/gnome-remote-desktop.nix
    ../../modules/gui-extras.nix
    ../../modules/gui.nix
    ../../modules/home.nix
    ../../modules/led.nix
    #../../modules/llm.nix
    ../../modules/msib450mpro.nix
    ../../modules/plymouth.nix
    ../../modules/printing.nix
    ../../modules/prometheus.nix
    ../../modules/secureboot.nix
    ../../modules/security.nix
    ../../modules/smart.nix
    ../../modules/ssh.nix
    ../../modules/virt.nix
    ../../modules/work.nix
  ];

  networking.hostName = "puffy"; # Define your hostname.

  services.xserver.videoDrivers = ["amdgpu"];

  # Enable AMD GPU overclocking
  boot.kernelParams = ["amdgpu.ppfeaturemask=0xfffffff"];

  # Enable nct6775 module for sensor readings
  boot.kernelModules = ["nct6775"];

  # Enable firmware service
  services.fwupd.enable = true;
}
