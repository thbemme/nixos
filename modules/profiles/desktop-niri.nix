{
  config,
  pkgs,
  vars,
  ...
}: {
  environment.systemPackages = with pkgs; [
    brightnessctl
    bluez
    kdePackages.qt5compat
    xwayland-satellite
  ];

  systemd.user.services.niri-flake-polkit.enable = false;

  # Niri system requirements (compositor configured via home-manager)
  hardware.graphics.enable = true;
  security.polkit.enable = true;

  # QT theming
  qt.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";

  # # Disable default display manager
  # services.xserver.displayManager.lightdm.enable = false;

  # # Start Niri on first login on tty1
  # environment.loginShellInit = ''
  #   if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  #     niri-session -l
  #   fi
  # '';

  services.displayManager = {
    enable = true;
    generic.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
    sessionPackages = [config.home-manager.users.${vars.user}.programs.niri.package];
    ly = {
      enable = true;
      settings = {
        animation = "matrix";
        auth_fails = 3;

        bigclock = "en";
        clear_password = true;
        default_input = "password";
        cmatrix_fg = "0xC11C84";
      };
    };
  };

  # X server for interfacing X11 apps with the Wayland protocol
  programs = {
    dconf.enable = true;
    xwayland.enable = true;
  };

  services = {
    accounts-daemon.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    power-profiles-daemon.enable = true;
    #seatd.enable = true;
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
