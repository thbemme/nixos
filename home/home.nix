{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
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
    ".config/fish/config.fish".source = ./dotfiles/config.fish;
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

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
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
    userName = "firstname lastname";
    userEmail = "firstname.lastname@maildomain.com";
  };

  # Use `dconf watch /` to track stateful changes you are doing, then set them here.
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "kitty.desktop"
        "org.gnome.Nautilus.desktop"
        "codium.desktop"
        "discord.desktop"
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
      cursor-theme = "McMojave-cursors";
      enable-animations = true;
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "full";
      gtk-theme = "Dracula-standard-buttons";
      icon-theme = "Dracula";
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
      clock-show-weekday = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      dynamic-workspaces = true;
    };
  };
}
