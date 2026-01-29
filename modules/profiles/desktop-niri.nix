{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  #  programs.dms-shell = {
  #    enable = true;
  #    systemd = {
  #      enable = true; # Systemd service for auto-start
  #      restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
  #    };
  #  };

  users.users.${vars.user} = {
    packages =
      (with pkgs; [
        cmus
        galculator
        nautilus
        tlp
        xwayland-satellite
      ])
      ++ (with pkgs-unstable; [
        ]);
  };

  systemd.user.services.niri-flake-polkit.enable = false;

  # Niri system requirements (compositor configured via home-manager)
  security.polkit.enable = true;
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  hardware.graphics.enable = true;
  security.pam.services.swaylock = {};

  # QT theming
  qt.enable = true;
  qt.platformTheme = "qt5ct";

  # greetd display manager
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
      user = "greeter";
    };
  };
  services.displayManager.sddm.enable = lib.mkForce false;

  # XDG portals
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
    config.common.default = "*"; # Use first available portal implementation
  };

  services.udisks2.enable = true;

  # DMS dependencies
  services.accounts-daemon.enable = true;
  services.power-profiles-daemon.enable = true;

  programs.xwayland.enable = true;

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/desktop-niri.nix;
    };
  };
}
