{ config, pkgs, ... }:

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
    ".config/MangoHud/MangoHud.conf".source = ./dotfiles/MangoHud.conf;
    ".config/ghostty/config".source = ./dotfiles/ghostty;
    ".config/hexchat/colors.conf".source = ./dotfiles/hexchat;
    ".themes/" = {
      source = ./dotfiles/themes;
      recursive = true;
    };
    ".icons/" = {
      source = ./dotfiles/icons;
      recursive = true;
    };
    ".config/gtk-3.0" = {
      source = ./dotfiles/gtk-3.0;
      recursive = true;
    };
    ".config/gtk-4.0" = {
      source = ./dotfiles/gtk-4.0;
      recursive = true;
    };
    ".config/qt5ct" = {
      source = ./dotfiles/qt5ct;
      recursive = true;
    };
    ".config/qt6ct" = {
      source = ./dotfiles/qt6ct;
      recursive = true;
    };
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  # Fix vscodium settings.json readonly issue
  home.activation.removeVSCodeSettingsBackup =
    let
      configDirName =
        {
          "vscode" = "Code";
          "vscode-insiders" = "Code - Insiders";
          "vscodium" = "VSCodium";
        }.${config.programs.vscode.package.pname};
    in
    {
      after = [ ];
      before = [ "checkLinkTargets" ];
      data = ''
        userDir=${config.xdg.configHome}/${configDirName}/User
        rm -rf $userDir/settings.json*
      '';
    };

  home.activation.makeVSCodeConfigWritable =
    let
      configDirName =
        {
          "vscode" = "Code";
          "vscode-insiders" = "Code - Insiders";
          "vscodium" = "VSCodium";
        }.${config.programs.vscode.package.pname};
      configPath = "${config.xdg.configHome}/${configDirName}/User/settings.json";
    in
    {
      after = [ "writeBoundary" ];
      before = [ ];
      data = ''
        install -m 0640 "$(readlink ${configPath})" ${configPath}
      '';
    };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
      jnoortheen.nix-ide
      timonwong.shellcheck
      streetsidesoftware.code-spell-checker

    ];
    userSettings = {
      "files.autoSave" = "afterDelay";
      "editor.fontSize" = 12;
      "terminal.integrated.fontSize" = 12;
      "editor.fontLigatures" = true;
      "editor.fontFamily" = "Fira Code";
      "editor.tabSize" = 2;
      "editor.mouseWheelZoom" = true;
      "editor.renderWhitespace" = "selection";
      "editor.cursorStyle" = "line";
      "editor.multiCursorModifier" = "alt";
      "editor.insertSpaces" = true;
      "editor.wordWrap" = "off";
      "workbench.colorTheme" = "Dracula";
      "files.exclude" = {
        "**/.git" = true;
        "**/.svn" = true;
        "**/.hg" = true;
        "**/CVS" = true;
        "**/.DS_Store" = true;
        "**/Thumbs.db" = true;
      };
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
        #"gamemode@christian.kellner.me"
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
  };
}
