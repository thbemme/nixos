{
  lib,
  pkgs,
  vars,
  ...
}: {
  users.users.${vars.user} = {
    packages = with pkgs; [
      power-profiles-daemon
      tlp
    ];
  };

  systemd.user.services.niri-flake-polkit.enable = false;

  # Niri system requirements (compositor configured via home-manager)
  security.polkit.enable = true;
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  hardware.graphics.enable = true;

  # QT theming
  qt.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";

  services.displayManager = {
    enable = true;
    environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
    ly = {
      enable = true;
      settings = {
        # doom, matrix, colormix, gameoflife
        animation = "matrix";
        auth_fails = 3;

        bigclock = "en";
        clear_password = true;
        default_input = "password";
        cmatrix_fg = "0xC11C84";
      };
    };
  };

  programs.niri = {
    enable = true;
  };

  services.displayManager.sddm.enable = lib.mkForce false;

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
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/desktop-niri.nix;
    };
  };
}
