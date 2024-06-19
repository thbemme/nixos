# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../default/default.nix
    ];

  networking.hostName = "puffy"; # Define your hostname.

  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.kernelParams = [ "rhgb" "quiet" "amdgpu.ppfeaturemask=0xffffffff" ];
  boot.kernelModules = [ "nct6775" ];
}
