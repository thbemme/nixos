{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/ai.nix
      ../../modules/amdgpu.nix
      ../../modules/default.nix
      ../../modules/desktop.nix
      ../../modules/dev.nix
      ../../modules/gaming.nix
      ../../modules/home.nix
      ../../modules/prometheus.nix
      ../../modules/security.nix
      ../../modules/virt.nix
      ../../modules/work.nix
    ];

  networking.hostName = "puffy"; # Define your hostname.

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Set G-512 keyboard backlight to blueviolet
  services.udev = {
    packages = [
      pkgs.g810-led
    ];
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", RUN+="${pkgs.g810-led}/bin/g810-led -a 8a2be2"
    '';
  };

  # Enable AMD GPU overclocking
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  # Enable nct6775 module for sensor readings
  boot.kernelModules = [ "nct6775" ];

}
