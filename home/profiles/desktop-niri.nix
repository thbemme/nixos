{pkgs, ...}: {
  imports = [
    ../apps/cmus.nix
    ../apps/dms.nix
    ../apps/mpv.nix
    ../apps/niri.nix
    #../apps/noctalia.nix
    ../apps/swayidle.nix
    ../apps/vicinae.nix
  ];

  home.packages = with pkgs; [
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
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XDG_SESSION_TYPE = "wayland";
  };

  services = {
    gnome-keyring.enable = true;

    udiskie = {
      enable = true;
    };
  };
}
