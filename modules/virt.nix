{ config, lib, pkgs, inputs, vars, ... }:

{
  users.users.${vars.user} = {
    packages = with pkgs; [
      gnome.gnome-boxes
    ];
  };

  environment.systemPackages = with pkgs; [
    qemu
  ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  systemd.tmpfiles.rules =
    let
      firmware =
        pkgs.runCommandLocal "qemu-firmware" { } ''
          mkdir $out
          cp ${pkgs.qemu}/share/qemu/firmware/*.json $out
          substituteInPlace $out/*.json --replace ${pkgs.qemu} /run/current-system/sw
        '';
    in
    [ "L+ /var/lib/qemu/firmware - - - - ${firmware}" ];
}
