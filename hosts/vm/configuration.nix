{pkgs, ...}: {
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

  # Fix for spice-vdagent not starting in VMs
  systemd.user.services.spice-vdagent-client = {
    enable = true;
    description = "spice-vdagent client";
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
      Restart = "always";
      RestartSec = "5";
    };
    unitConfig = {
      After = ["graphical-session-pre.target"];
      PartOf = ["graphical-session.target"];
    };
  };
  networking.hostName = "vm"; # Define your hostname.
}
