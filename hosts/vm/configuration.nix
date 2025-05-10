{ ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/default.nix
    ../../modules/desktop.nix
    ../../modules/home.nix
    ../../modules/ssh.nix
  ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  networking.hostName = "vm"; # Define your hostname.
}
