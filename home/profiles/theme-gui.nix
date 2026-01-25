{
  config,
  pkgs,
  vars,
  ...
}: let
  # Helpers / constants to reduce repetition and improve readability
  userHome = "/home/${vars.user}";
  draculaThemeDir = "${userHome}/.themes/Dracula-slim-standard-buttons";

  # small helper to create out-of-store symlink entries for home.file
  symlink = path: {source = config.lib.file.mkOutOfStoreSymlink path;};
in {
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
        url = "https://github.com/dracula/gtk/archive/refs/heads/slim-standard-buttons.zip";
        hash = "sha256-zL2mgNjnYcmJLyQa2wq2pOhgHlNMolBZ0y9Y3Rn6Y8w=";
      };
    };

    ".icons/Dracula" = {
      source = pkgs.fetchzip {
        url = "https://github.com/dracula/gtk/files/5214870/Dracula.zip";
        hash = "sha256-rcSKlgI3bxdh4INdebijKElqbmAfTwO+oEt6M2D1ls0=";
      };
    };

    # Symlink assets from the installed theme directory into ~/.config so apps find them.
    ".config/assets" = symlink "${draculaThemeDir}/assets";
    ".config/gtk-4.0/gtk.css" = symlink "${draculaThemeDir}/gtk-4.0/gtk.css";
    ".config/gtk-4.0/gtk-dark.css" = symlink "${draculaThemeDir}/gtk-4.0/gtk-dark.css";
  };

  # dconf settings (stateful GUI settings) — set these after capturing them with `dconf watch /`
  dconf.settings = {
    # Ensure the user-theme extension points to the theme directory name
    "org/gnome/shell/extensions/user-theme" = {
      name = "Dracula-slim-standard-buttons";
    };

    # Interface settings: themes, icons, cursor, clock, animations
    "org/gnome/desktop/interface" = {
      cursor-theme = "oreo_spark_purple_bordered_cursors";
      gtk-theme = "Dracula-slim-standard-buttons";
      icon-theme = "Dracula";
    };

    # Text Editor (GNOME Text Editor) preferences: use mkUint32 for integer types
    "org/gnome/TextEditor" = {
      style-scheme = "dracula";
    };
  };

  programs.vscode = {
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
      ];
      userSettings = {
        "workbench.colorTheme" = "Dracula Theme";
      };
    };
  };
}
