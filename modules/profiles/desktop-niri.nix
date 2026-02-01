{
  inputs,
  lib,
  pkgs,
  pkgs-unstable,
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

  # # greetd display manager
  # services.greetd = {
  #   enable = true;
  #   settings.default_session = {
  #     command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --asterisks-char ● --theme 'time=lightred;container=black;border=grey;text=white;greet=lightblue;prompt=green;input=lightgreen;action=lightblue;button=yellow;' --cmd niri-session";
  #     user = "greeter";
  #   };
  # };

  programs.regreet = let
    background =
      pkgs.fetchurl
      {
        url = "https://i.redd.it/pivo53w9nyd51.jpg";
        hash = "sha256-5QjFGb1wO5qfWimRYIAF6BEesxrsZg1AXC3MhKutcEg=";
      };
  in {
    enable = true;
    settings = {
      background = {
        path = background;
        fit = "Cover";
      };
      GTK = {
        application_prefer_dark_theme = true;
      };
    };
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
    font = {
      size = 10;
    };
  };

  programs.niri = {
    enable = true;
  };

  services.displayManager.sddm.enable = lib.mkForce false;

  # XDG portals
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
    config.common.default = "*"; # Use first available portal implementation
  };

  # Virtual file systems for Nautilus
  services.gvfs.enable = true;

  # D-Bus service for power management
  services.upower.enable = true;

  # X server for interfacing X11 apps with the Wayland protocol
  programs.xwayland.enable = true;

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/desktop-niri.nix;
    };
  };
}
