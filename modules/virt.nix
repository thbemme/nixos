{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  users.users.user = {
    packages = with pkgs; [
      gnome.gnome-boxes
    ];
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
