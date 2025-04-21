{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/ai.nix
      ../../modules/amdgpu.nix
      ../../modules/default.nix
      ../../modules/desktop-software.nix
      ../../modules/desktop.nix
      ../../modules/dev.nix
      ../../modules/g512.nix
      ../../modules/gaming.nix
      ../../modules/home.nix
      ../../modules/msib450mpro.nix
      ../../modules/printing.nix
      ../../modules/prometheus.nix
      ../../modules/secureboot.nix
      ../../modules/security.nix
      ../../modules/ssh.nix
      ../../modules/virt.nix
      ../../modules/work.nix
    ];

  networking.hostName = "puffy"; # Define your hostname.

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable AMD GPU overclocking
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  # Enable nct6775 module for sensor readings
  boot.kernelModules = [ "nct6775" ];

  # Enable firmware service
  services.fwupd.enable = true;
}
