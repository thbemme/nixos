{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/cli.nix
    ../../modules/default.nix
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
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  networking.hostName = "vm"; # Define your hostname.
}
