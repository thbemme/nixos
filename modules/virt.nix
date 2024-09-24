{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  users.users.user = {
    packages = with pkgs; [
      gnome.gnome-boxes
    ];
  };

  environment.systemPackages = with pkgs; [
    qemu
  ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
