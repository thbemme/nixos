{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/profiles/default.nix
    ../../modules/profiles/desktop-extras.nix
    #../../modules/profiles/desktop-gnome.nix
    ../../modules/profiles/desktop-minimal.nix
    ../../modules/profiles/desktop-niri.nix
    ../../modules/profiles/gaming.nix
    ../../modules/profiles/home.nix
    ../../modules/profiles/security.nix
    ../../modules/profiles/work.nix
    ../../modules/services/printing.nix
    ../../modules/services/smart.nix
    ../../modules/services/ssh.nix
    ../../modules/system/btrfs.nix
    ../../modules/system/hibernate.nix
    ../../modules/system/hosts.nix
    ../../modules/system/kernel-desktop.nix
    ../../modules/system/plymouth.nix
    ../../modules/system/secureboot.nix
  ];

  networking.hostName = "puff"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable firmware service
  services.fwupd.enable = true;
}
