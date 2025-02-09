{ ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/default.nix
      ../../modules/desktop.nix
      ../../modules/home.nix
      ../../modules/secureboot.nix
      ../../modules/security.nix
      ../../modules/work.nix
    ];

  networking.hostName = "puff"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
