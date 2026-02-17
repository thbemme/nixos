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
    QT_QPA_PLATFORM = "wayland";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  services = {
    gnome-keyring.enable = true;

    udiskie = {
      enable = true;
    };
  };
}
