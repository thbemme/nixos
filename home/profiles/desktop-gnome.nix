{
  pkgs,
  lib,
  vars,
  ...
}:
with lib.hm.gvariant; # bring mkUint32 etc. into scope

  let
    # Consolidate GNOME extensions list in one place (keeps home.packages cleaner)
    gnomeExtensionsList = with pkgs.gnomeExtensions; [
      appindicator
      blur-my-shell
      dash-to-dock
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
      "steam.desktop"
      "Path of Exile.desktop"
      "Path of Exile 2.desktop"
    ];

    enabledExtensions = [
      "appindicatorsupport@rgcjonas.gmail.com"
      "blur-my-shell@aunetx"
      "dash-to-dock@micxgx.gmail.com"
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

    # Set bookmarks (use force if replacing)
    home.file.".config/gtk-3.0/bookmarks" = {
      text = ''
        file:///home/${vars.user}/Documents
        file:///home/${vars.user}/Downloads
        file:///home/${vars.user}/Pictures
        file:///home/${vars.user}/Music
        file:///home/${vars.user}/Videos
        file:///home/${vars.user}/kbnetcloud
        file:///home/${vars.user}/.local/share/Cryptomator/mnt/GDrive GDrive
        file:///media
        smb://blowfish/incoming/ incoming on blowfish
        smb://blowfish/media/ media on blowfish
      '';
      force = true;
    };

    # dconf settings (stateful GUI settings) — set these after capturing them with `dconf watch /`
    dconf.settings = {
      # Window manager / compositor settings
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        experimental-features = ["variable-refresh-rate"];
      };

      # Core Shell settings: favourites and enabled extensions pulled from variables above
      "org/gnome/shell" = {
        disable-user-extensions = false;
        favorite-apps = favoriteApps;
        enabled-extensions = enabledExtensions;
      };

      # Interface settings: themes, icons, cursor, clock, animations
      "org/gnome/desktop/interface" = {
        clock-format = "24h";
        clock-show-date = true;
        clock-show-weekday = true;
        enable-animations = true;
        enable-hot-corners = false;
      };

      # Location / timezone / sound / lockscreen settings
      "org/gnome/system/location" = {enabled = true;};
      "org/gnome/desktop/datetime" = {automatic-timezone = true;};
      "org/gnome/desktop/sound" = {event-sounds = false;};
      "org/gnome/desktop/lockdown" = {disable-lock-screen = false;};

      # Text Editor (GNOME Text Editor) preferences: use mkUint32 for integer types
      "org/gnome/TextEditor" = {
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

      # File chooser should list directories first and show hidden
      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true;
        sort-directories-first = true;
      };

      # Default Icon sizing in nautilus
      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = "small-plus";
      };

      # Default icon view in nautilus
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "icon-view";
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
