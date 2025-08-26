{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/btrfs.nix
    ../../modules/cli.nix
    ../../modules/default.nix
    ../../modules/desktop-kernel.nix
    ../../modules/gaming.nix
    ../../modules/gnome.nix
    ../../modules/gui-extras.nix
    ../../modules/gui.nix
    ../../modules/hibernate.nix
    ../../modules/home.nix
    ../../modules/plymouth.nix
    ../../modules/secureboot.nix
    ../../modules/security.nix
    ../../modules/ssh.nix
    ../../modules/work.nix
  ];

  networking.hostName = "puff"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable firmware service
  services.fwupd.enable = true;
}
