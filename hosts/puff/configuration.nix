{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/profiles/cli-packages.nix
    ../../modules/profiles/default.nix
    ../../modules/profiles/gaming.nix
    ../../modules/profiles/gnome.nix
    ../../modules/profiles/gui-extras.nix
    ../../modules/profiles/gui-minimal.nix
    ../../modules/profiles/home.nix
    ../../modules/profiles/security.nix
    ../../modules/profiles/work.nix
    ../../modules/services/printing.nix
    ../../modules/services/smart.nix
    ../../modules/services/ssh.nix
    ../../modules/system/btrfs.nix
    ../../modules/system/hibernate.nix
    ../../modules/system/kernel-desktop.nix
    ../../modules/system/plymouth.nix
    ../../modules/system/secureboot.nix
  ];

  networking.hostName = "puff"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable firmware service
  services.fwupd.enable = true;
}
