{pkgs, ...}: {
  imports = [
    ../apps/dms.nix
    ../apps/mpv.nix
    ../apps/niri.nix
    ../apps/rmpc.nix
    ../apps/swayidle.nix
    ../apps/yazi.nix
  ];

  home.packages = with pkgs; [
    gpu-screen-recorder
    kdePackages.qt6ct
    libqalculate
    nautilus
    pwvucontrol
    qalculate-gtk
    simple-scan
    wiremix
    wl-clipboard-rs
    xwayland-satellite
  ];

  home.sessionVariables = {
    DISPLAY = ":0";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  services = {
    gnome-keyring.enable = true;

    udiskie = {
      enable = true;
    };
  };
}
