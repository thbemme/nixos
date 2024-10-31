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

  users.users.user = {
    extraGroups = [ "gamemode" ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

}
