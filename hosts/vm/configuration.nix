{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/profiles/cli-packages.nix
    ../../modules/profiles/default.nix
    ../../modules/profiles/gnome.nix
    ../../modules/profiles/gui-extras.nix
    ../../modules/profiles/gui-minimal.nix
    ../../modules/profiles/home.nix
    ../../modules/profiles/security.nix
    ../../modules/profiles/work.nix
    ../../modules/services/ssh.nix
    ../../modules/system/btrfs.nix
    ../../modules/system/hosts.nix
    ../../modules/system/kernel-desktop.nix
    ../../modules/system/plymouth.nix
  ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  networking.hostName = "vm"; # Define your hostname.
}
