{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/aicpu.nix
      ../../modules/default.nix
      ../../modules/desktop.nix
      ../../modules/games.nix
      ../../modules/home.nix
      ../../modules/security.nix
    ];

  networking.hostName = "puff"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
