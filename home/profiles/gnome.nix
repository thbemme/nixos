{
  config,
  pkgs,
  vars,
  lib,
  ...
}:
with lib.hm.gvariant; # bring mkUint32 etc. into scope

  let
    # Helpers / constants to reduce repetition and improve readability
    userHome = "/home/${vars.user}";
    draculaThemeDir = "${userHome}/.themes/Dracula-standard-buttons";

    # small helper to create out-of-store symlink entries for home.file
    symlink = path: {source = config.lib.file.mkOutOfStoreSymlink path;};

    # Consolidate GNOME extensions list in one place (keeps home.packages cleaner)
    gnomeExtensionsList = with pkgs.gnomeExtensions; [
      appindicator
      blur-my-shell
      dash-to-dock
      freon
      just-perfection
      gamemode-shell-extension
      nothing-to-say
      rounded-corners
      user-avatar-in-quick-settings
      user-themes
      vitals
      weather-or-not
    ];

    # Favorite apps and extension UUIDs kept as separate lists for maintainability
    favoriteApps = [
      "librewolf.desktop"
      "firefox.desktop"
      "firefox-esr.desktop"
      "com.mitchellh.ghostty.desktop"
      "org.gnome.Nautilus.desktop"
      "codium.desktop"
      "vesktop.desktop"
      "io.github.Hexchat.desktop"
      "steam.desktop"
      "Path of Exile.desktop"
      "Path of Exile 2.desktop"
    ];

    enabledExtensions = [
      "appindicatorsupport@rgcjonas.gmail.com"
      "blur-my-shell@aunetx"
      "dash-to-dock@micxgx.gmail.com"
      #"freon@UshakovVasilii_Github.yahoo.com"
      "gamemodeshellextension@trsnaqe.com"
      "just-perfection-desktop@just-perfection"
      "nothing-to-say@extensions.gnome.wouter.bolsterl.ee"
      "quick-settings-avatar@d-go"
      "Rounded_Corners@lennart-k"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "Vitals@CoreCoding.com"
      "weatherornot@somepaulo.github.io"
    ];
  in {
    # Install the GNOME Shell extensions (package wrappers provided by Nixpkgs)
    home.packages = gnomeExtensionsList;

    # Home files: fetch remote assets + symlink local theme assets into ~/.config
    # Keep all fetched assets explicit and pinned with hashes.
    home.file = {
      # GTK SourceView syntax style (Dracula) for gedit/other editors using gv
      ".local/share/gtksourceview-5/styles/dracula.xml" = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml";
          hash = "sha256-ZkY523+xgP6NRpRaOKUPuim28kpgw3IbMWZGS6bBIPY=";
        };
      };

      # Theme / icon bundles fetched from upstream; pinned with hashes
      "${draculaThemeDir}" = {
        source = pkgs.fetchzip {
          url = "https://github.com/dracula/gtk/archive/refs/heads/standard-buttons.zip";
          hash = "sha256-PU7sjeh8KHb9mOVhgRRvR1w4KWPRy88terN/yjnJdPA=";
        };
      };

      ".icons/Dracula" = {
        source = pkgs.fetchzip {
          url = "https://github.com/dracula/gtk/files/5214870/Dracula.zip";
          hash = "sha256-rcSKlgI3bxdh4INdebijKElqbmAfTwO+oEt6M2D1ls0=";
        };
      };

      # Local dotfiles from sibling `../dotfiles` directory (use force if replacing)
      ".config/gtk-3.0/bookmarks" = {
        source = ../dotfiles/bookmarks;
        force = true; # allow overriding existing file in home
      };

      # Symlink assets from the installed theme directory into ~/.config so apps find them.
      ".config/assets" = symlink "${draculaThemeDir}/assets";
      ".config/gtk-4.0/gtk.css" = symlink "${draculaThemeDir}/gtk-4.0/gtk.css";
      ".config/gtk-4.0/gtk-dark.css" = symlink "${draculaThemeDir}/gtk-4.0/gtk-dark.css";

      # Qt config files from local dotfiles
      ".config/qt5ct" = {source = ../dotfiles/qt5ct;};
      ".config/qt6ct" = {source = ../dotfiles/qt6ct;};
    };

    # dconf settings (stateful GUI settings) — set these after capturing them with `dconf watch /`
    dconf.settings = {
      # Window manager / compositor settings
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        experimental-features = ["variable-refresh-rate"];
      };

      # Desktop background: use `rec` so `picture-uri-dark` points to same value as `picture-uri`
      "org/gnome/desktop/background" = rec {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "https://i.redd.it/pivo53w9nyd51.jpg";
        picture-uri-dark = picture-uri;
        primary-color = "#000000";
      };

      # Core Shell settings: favourites and enabled extensions pulled from variables above
      "org/gnome/shell" = {
        disable-user-extensions = false;
        favorite-apps = favoriteApps;
        enabled-extensions = enabledExtensions;
      };

      # Ensure the user-theme extension points to the theme directory name
      "org/gnome/shell/extensions/user-theme" = {
        name = "Dracula-standard-buttons";
      };

      # Interface settings: themes, icons, cursor, clock, animations
      "org/gnome/desktop/interface" = {
        clock-format = "24h";
        clock-show-date = true;
        clock-show-weekday = true;
        cursor-theme = "oreo_spark_purple_bordered_cursors";
        enable-animations = true;
        enable-hot-corners = false;
        gtk-theme = "Dracula-standard-buttons";
        icon-theme = "Dracula";
      };

      # Location / timezone / sound / lockscreen settings
      "org/gnome/system/location" = {enabled = true;};
      "org/gnome/desktop/datetime" = {automatic-timezone = true;};
      "org/gnome/desktop/sound" = {event-sounds = false;};
      "org/gnome/desktop/lockdown" = {disable-lock-screen = false;};

      # Text Editor (GNOME Text Editor) preferences: use mkUint32 for integer types
      "org/gnome/TextEditor" = {
        style-scheme = "dracula";
        highlight-current-line = true;
        show-map = true;
        show-line-numbers = true;
        tab-width = mkUint32 2;
      };

      # Calendar preferences
      "org/gnome/desktop/calendar" = {
        show-weekdate = true;
        clock-show-weekday = true;
      };

      # Window manager preferences
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
        dynamic-workspaces = true;
      };

      # File chooser should list directories first
      "org/gtk/gtk4/settings/file-chooser" = {
        sort-directories-first = true;
      };

      # Custom keybinding for Launching Ghostty (Super+Return)
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

      # Per-extension configuration blocks (only include what you actually need)
      "org/gnome/shell/extensions/nothing-to-say" = {
        icon-visibility = "always";
        keybinding-toggle-mute = ["F9"];
        play-feedback-sounds = false;
        show-osd = false;
      };

      "org/gnome/shell/extensions/just-perfection" = {
        clock-menu-position = 1;
        clock-menu-position-offset = 20;
        notification-banner-position = 2;
        panel-button-padding-size = 6;
        startup-status = 0;
        theme = true;
        window-demands-attention-focus = true;
        workspace-wrap-around = true;
      };

      "org/gnome/shell/extensions/weatherornot" = {position = "right";};

      "org/gnome/shell/extensions/dash-to-dock" = {
        apply-custom-theme = true;
        custom-theme-shrink = true;
        dash-max-icon-size = 32;
        dock-position = "LEFT";
        show-icons-emblems = false;
        show-mounts = false;
        show-trash = false;
      };

      # "org/gnome/shell/extensions/freon" = {
      #   hot-sensors = ["__max__"];
      # };

      "org/gnome/shell/extensions/vitals" = {
        alphabetize = true;
        hide-zeros = true;
        hot-sensors = ["__temperature_max__"];
        icon-style = true;
      };

      "org/gnome/shell/extensions/gamemodeshellextension" = {
        active-color = "rgb(138,42,226)";
        show-close-notification = false;
        show-icon-only-when-active = true;
        show-launch-notification = false;
      };

      # Weather units
      "org/gnome/GWeather4" = {temperature-unit = "centigrade";};
    };
  }
