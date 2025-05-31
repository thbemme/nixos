{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/ai.nix
    ../../modules/amdgpu-patch/default.nix
    ../../modules/amdgpu.nix
    ../../modules/cli.nix
    ../../modules/default.nix
    ../../modules/dev.nix
    ../../modules/gaming.nix
    ../../modules/gui-extras.nix
    ../../modules/gui.nix
    ../../modules/home.nix
    ../../modules/led.nix
    ../../modules/msib450mpro.nix
    ../../modules/printing.nix
    ../../modules/prometheus.nix
    ../../modules/secureboot.nix
    ../../modules/security.nix
    ../../modules/ssh.nix
    ../../modules/plymouth.nix
    ../../modules/gnome.nix
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
