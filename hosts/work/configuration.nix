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
      ../../modules/vim.nix
    ];
  services.xserver = { modules = [ pkgs.xorg.xf86videofbdev ]; videoDrivers = [ "hyperv_fb" ]; };
  users.users.gdm = { extraGroups = [ "video" ]; };
  networking.hostName = "work"; # Define your hostname.
  virtualisation.hypervGuest = {
    enable = true;
    videoMode = "1920x1080";
  };
  boot.blacklistedKernelModules = [ "hyperv_fb" ];
}
