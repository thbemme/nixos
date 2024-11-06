{ config, pkgs, inputs, vars, ... }:

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
    #".config/btop/btop.conf".source = ./dotfiles/btop.conf;
    ".config/kitty/kitty.conf".source = ./dotfiles/kitty.conf;
    ".config/kitty/dracula.conf".source = ./dotfiles/dracula.conf;
    ".config/fish/conf.d/desktop.fish".source = ./dotfiles/desktop.fish;
    ".config/MangoHud/MangoHud.conf".source = ./dotfiles/MangoHud.conf;
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
    EDITOR = "vim";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;

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
        rm -rf $userDir/settings.json.hm-back
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
      "workbench.colorTheme" = "Dracula Theme";
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

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Dracula";
      theme_background = false;
    };
  };

  programs.git = {
    enable = true;
    userName = "${vars.gitName}";
    userEmail = "${vars.gitEmail}";
    extraConfig = {
      credential.helper = "store";
    };
  };

  # Use `dconf watch /` to track stateful changes you are doing, then set them here.
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "variable-refresh-rate" ];
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "kitty.desktop"
        "org.gnome.Nautilus.desktop"
        "codium.desktop"
        "vesktop.desktop"
        "steam.desktop"
        "Path of Exile.desktop"
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
      color-scheme = "prefer-dark";
      font-name = "Inter Display 10";
      document-font-name = "Inter 10";
      monospace-font-name = "Fira Code 10 @wght=400";
      font-hinting = "full";
      font-antialiasing = "rgba";
      text-scaling-factor = "0.95";
      cursor-theme = "McMojave-cursors";
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
  };
}
