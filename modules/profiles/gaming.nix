{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  users.users.${vars.user} = {
    packages =
      (with pkgs; [
        adwsteamgtk
        ecwolf
        furmark
        gzdoom
        protonup-qt
        scummvm
        sdlpop
      ])
      ++ (with pkgs-unstable; [
        lutris
        rusty-path-of-building
      ]);
    extraGroups = ["gamemode"];
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.staging
    winetricks
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  # Kernel parameters for gaming
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
    "fs.file-max" = 524288;
  };
  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/gaming.nix;
    };
  };
}
