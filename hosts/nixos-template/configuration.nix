{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/profiles/default.nix
    ../../modules/profiles/server.nix
    ../../modules/services/ssh.nix
    ../../modules/system/btrfs.nix
    ../../modules/system/kernel-server.nix
  ];
  services.qemuGuest.enable = true;
  networking.hostName = "nixos-template"; # Define your hostname.
  nix.settings.trusted-users = ["@wheel"];
}
