{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/btrfs.nix
    ../../modules/default.nix
    ../../modules/kernel-server.nix
    ../../modules/server.nix
    ../../modules/ssh.nix
  ];
  services.qemuGuest.enable = true;
  networking.hostName = "nixos-template"; # Define your hostname.
  nix.settings.trusted-users = ["@wheel"];
}
