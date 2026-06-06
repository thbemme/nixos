{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: let
  #background-image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
  background-image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-rainbow.svg";
    sha256 = "sha256-gMeJgiSSA5hFwtW3njZQAd4OHji6kbRCJKVoN6zsRbY=";
  };
in {
  environment.systemPackages = with pkgs; [
    brightnessctl
    bluez
    kdePackages.qt5compat
    xwayland-satellite
  ];

  systemd.user.services.niri-flake-polkit.enable = false;

  # Niri system requirements (compositor configured via home-manager)
  hardware.graphics.enable = true;
  programs.dconf.enable = true;
  security.polkit.enable = true;

  # QT theming
  qt.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";

  services.displayManager = {
    defaultSession = "niri";
    enable = true;
    generic.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${pkgs.where-is-my-sddm-theme.override {
        variants = ["qt6"];
        themeConfig.General = {
          background = background-image;
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
      }}/share/sddm/themes/where_is_my_sddm_theme";
    };
    sessionPackages = [pkgs.niri];
  };

  # X server for interfacing X11 apps with the Wayland protocol
  programs.xwayland.enable = true;

  services = {
    accounts-daemon.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = [
      "gtk"
      "gnome"
    ];
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/desktop-niri.nix;
    };
  };
}
