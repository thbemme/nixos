{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  nixpkgs.overlays = [
    # Workaround till https://github.com/NixOS/nixpkgs/issues/514113 is backported to 26.05
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = false; # False is a bit more honest on x86_64 systems
      };
    })
  ];

  environment.systemPackages =
    (with pkgs; [
      adwsteamgtk
      ecwolf
      furmark
      gzdoom
      limo
      lutris
      protonup-qt
      scummvm
      sdlpop
      winetricks
      wineWow64Packages.staging
    ])
    ++ (with pkgs-unstable; [
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
