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
        brogue-ce
        ecwolf
        furmark
        gzdoom
        lutris
        protonup-qt
        scummvm
        sdlpop
        zeroad
        zeroad-unwrapped
        zeroad-data
      ])
      ++ (with pkgs-unstable; [
        #path-of-building
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

  boot.kernel.sysctl."vm.max_map_count" = 2147483642;

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../home/gaming.nix;
    };
  };
}
