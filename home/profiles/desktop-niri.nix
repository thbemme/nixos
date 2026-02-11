{pkgs, ...}: {
  imports = [
    ../apps/cmus.nix
    ../apps/niri.nix
    ../apps/noctalia.nix
    ../apps/swayidle.nix
    ../apps/vicinae.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    gpu-screen-recorder
    kdePackages.qt6ct
    mission-center
    nautilus
    nirius
    pwvucontrol
    qalculate-gtk
    simple-scan
    wl-clipboard-rs
    wlsunset
    xwayland-satellite
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  services.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.niri = {
      default = [
        "gtk"
        "gnome"
      ];
      "org.freedesktop.impl.portal.Access" = ["gtk"];
      "org.freedesktop.impl.portal.Notification" = ["gtk"];
      "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
      "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      "org.freedesktop.impl.portal.ScreenCast" = ["xdg-desktop-portal-gnome"];
      "org.freedesktop.impl.portal.Screenshot" = ["xdg-desktop-portal-gnome"];
    };
    extraPortals = [
      pkgs.gnome-keyring
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  services.udiskie = {
    enable = true;
  };
}
