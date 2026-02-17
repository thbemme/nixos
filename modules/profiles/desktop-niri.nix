{
  inputs,
  lib,
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        backgroundMode = "none";
        passwordCharacter = "•";
        passwordInputWidth = "1";
        passwordMask = true;
        passwordInputCursorVisible = false;
        passwordFontSize = 8;
        sessionsFontSize = 8;
        usersFontSize = 8;
        blurRadius = "";
        helpFontSize = 8;
      };
    })
    pkgs.brightnessctl
    pkgs.bluez
    pkgs-unstable.dgop
  ];

  systemd.user.services.niri-flake-polkit.enable = false;

  # Niri system requirements (compositor configured via home-manager)
  hardware.graphics.enable = true;
  programs.dconf.enable = true;
  security.polkit.enable = true;

  # QT theming
  #qt.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";

  services.displayManager = {
    enable = true;
    environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "where_is_my_sddm_theme";
    };
  };

  programs.niri = {
    enable = true;
  };

  # X server for interfacing X11 apps with the Wayland protocol
  programs.xwayland.enable = true;

  services = {
    # Virtual file systems for Nautilus
    gvfs.enable = true;

    # D-Bus service for power management
    upower.enable = true;

    # Calendar data
    gnome.evolution-data-server.enable = true;
    gnome.gnome-online-accounts.enable = true;

    blueman.enable = true;

    power-profiles-daemon.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "gtk";
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/desktop-niri.nix;
    };
  };
}
