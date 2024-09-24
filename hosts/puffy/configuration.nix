# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../default/default.nix
      ../../modules/gaming.nix
      ../../modules/ai.nix
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
  boot.kernelParams = [ "rhgb" "quiet" "amdgpu.ppfeaturemask=0xffffffff" ];

  # Enable nct6775 module for sensor readings
  boot.kernelModules = [ "nct6775" ];

}
