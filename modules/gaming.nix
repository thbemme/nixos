{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  users.users.user = {
    packages = (with pkgs; [
      adwsteamgtk
      ecwolf
      furmark
      gzdoom
      lutris
      mangohud
      protonup-qt
      scummvm
      wowup-cf
    ]) ++
    (with pkgs-unstable; [
      path-of-building
    ]);
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.staging
    winetricks
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.gamemode.enable = true;
}
