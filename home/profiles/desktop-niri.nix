{pkgs, ...}: {
  imports = [
    ../apps/dms.nix
    ../apps/mpv.nix
    ../apps/niri.nix
    ../apps/rmpc.nix
    ../apps/yazi.nix
  ];

  home.packages = with pkgs; [
    kdePackages.qt6ct
    libqalculate
    nautilus
    pwvucontrol
    qalculate-gtk
    simple-scan
    wiremix
  ];

  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    NIXOS_OZONE_WL = "1";
    OZONE_PLATFORM = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  services = {
    easyeffects.enable = true;
    gnome-keyring.enable = true;
    udiskie.enable = true;
  };
}
