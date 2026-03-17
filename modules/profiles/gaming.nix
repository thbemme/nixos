{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      adwsteamgtk
      ecwolf
      furmark
      gzdoom
      limo
      protonup-qt
      scummvm
      sdlpop
      winetricks
      wineWowPackages.staging
    ])
    ++ (with pkgs-unstable; [
      lutris
      rusty-path-of-building
    ]);

  users.users.${vars.user}.extraGroups = ["gamemode"];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    gamemode.enable = true;
    gamescope.enable = true;
  };

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
