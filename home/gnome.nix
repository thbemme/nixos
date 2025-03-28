{ config, pkgs, vars, ... }:

{
  home.packages = [
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.freon
    #pkgs.gnomeExtensions.gamemode-indicator-in-system-settings
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.nothing-to-say
    pkgs.gnomeExtensions.rounded-corners
    pkgs.gnomeExtensions.user-avatar-in-quick-settings
    pkgs.gnomeExtensions.user-themes
    pkgs.gnomeExtensions.weather-or-not
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through "home.file".
  home.file = {
    # # Building this configuration will create a copy of "dotfiles/screenrc" in
    # # the Nix store. Activating the configuration will then make "~/.screenrc" a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ""
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # "";
    ".themes/Dracula-standard-buttons" = {
      source = pkgs.fetchzip {
        url = "https://github.com/dracula/gtk/archive/refs/heads/standard-buttons.zip";
        hash = "sha256-V0l9rUpuHT1aptUc4TBf97zEzGrDHGgUDE1EEOhOaUM=";
      };
    };
    ".icons/Dracula" = {
      source = pkgs.fetchzip {
        url = "https://github.com/dracula/gtk/files/5214870/Dracula.zip";
        hash = "sha256-rcSKlgI3bxdh4INdebijKElqbmAfTwO+oEt6M2D1ls0=";
      };
    };
    ".config/gtk-3.0/bookmarks".source = ./dotfiles/bookmarks;
    ".config/assets".source = config.lib.file.mkOutOfStoreSymlink "/home/${vars.user}/.themes/Dracula-standard-buttons/assets";
    ".config/gtk-4.0/gtk.css".source = config.lib.file.mkOutOfStoreSymlink "/home/${vars.user}/.themes/Dracula-standard-buttons/gtk-4.0/gtk.css";
    ".config/gtk-4.0/gtk-dark.css".source = config.lib.file.mkOutOfStoreSymlink "/home/${vars.user}/.themes/Dracula-standard-buttons/gtk-4.0/gtk-dark.css";
    ".config/qt5ct" = {
      source = ./dotfiles/qt5ct;
    };
    ".config/qt6ct" = {
      source = ./dotfiles/qt6ct;
    };
  };

  # Use `dconf watch /` to track stateful changes you are doing, then set them here.
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "variable-refresh-rate" ];
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "librewolf.desktop"
        "com.mitchellh.ghostty.desktop"
        "org.gnome.Nautilus.desktop"
        "codium.desktop"
        "vesktop.desktop"
        "io.github.Hexchat.desktop"
        "steam.desktop"
        "Path of Exile.desktop"
        "Path of Exile 2.desktop"
      ];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.maildomain.com"
        "blur-my-shell@aunetx"
        "dash-to-dock@micxgx.maildomain.com"
        "freon@UshakovVasilii_Github.yahoo.com"
        "gamemode@christian.kellner.me"
        "just-perfection-desktop@just-perfection"
        "nothing-to-say@extensions.gnome.wouter.bolsterl.ee"
        "quick-settings-avatar@d-go"
        "Rounded_Corners@lennart-k"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "weatherornot@somepaulo.github.io"
      ];
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Dracula-standard-buttons";
    };
    "org/gnome/desktop/interface" = {
      cursor-theme = "oreo_spark_purple_bordered_cursors";
      enable-animations = true;
      enable-hot-corners = false;
      gtk-theme = "Dracula-standard-buttons";
      icon-theme = "Dracula";
    };
    "org/gnome/desktop/lockdown" = {
      disable-lock-screen = false;
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
      clock-show-weekday = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      dynamic-workspaces = true;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Ghostty";
      command = "ghostty";
      binding = "<Super>Return";
    };
    "org/gnome/shell/extensions/nothing-to-say" = {
      icon-visibility = "always";
      keybinding-toggle-mute = [ "F9" ];
      play-feedback-sounds = false;
      show-osd = false;
    };
    "org/gnome/shell/extensions/just-perfection" = {
      clock-menu-position = 1;
      clock-menu-position-offset = 20;
      panel-button-padding-size = 6;
      startup-status = 0;
      theme = true;
      window-demands-attention-focus = true;
      workspace-wrap-around = true;
    };
    "org/gnome/shell/extensions/weatherornot" = {
      position = "right";
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = true;
      custom-theme-shrink = true;
      dash-max-icon-size = 32;
      dock-position = "LEFT";
      show-icons-emblems = false;
      show-mounts = false;
      show-trash = false;
    };
    "org/gnome/shell/extensions/freon" = {
      hot-sensors = [ "__max__" ];
    };
    "org/gnome/shell/extensions/gamemodeshellextension" = {
      show-icon-only-when-active = true;
    };
  };
}
