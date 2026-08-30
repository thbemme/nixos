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
      heroic
      limo
      protonup-qt
      scummvm
      sdlpop
      winetricks
      wineWow64Packages.staging
    ])
    ++ (with pkgs-unstable; [
      rusty-path-of-building
    ]);

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
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
