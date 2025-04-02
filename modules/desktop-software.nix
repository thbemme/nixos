{ pkgs, pkgs-unstable, inputs, vars, ... }:

{

  users.users.${vars.user} = {
    packages = (with pkgs; [
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })
      easyeffects
      ffmpeg-full
      gimp-with-plugins
      gpu-viewer
      hexchat
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_US
      krita
      libreoffice
      libsForQt5.qt5ct
      lyx
      nextcloud-client
      openshot-qt
      oreo-cursors-plus
      paper-plane
      papirus-icon-theme
      phoronix-test-suite
      pika-backup
      revolt-desktop
      stellarium
      tor-browser
      transmission_4-gtk
      vlc
      vscodium
      whatsapp-for-linux
    ]) ++
    (with pkgs-unstable; [
      cryptomator
      handbrake
    ]);
  };

  environment.systemPackages = with pkgs; [
    btrfs-assistant
    lm_sensors
    xsane
    xsensors
  ];

  environment.variables = { TERMINAL = "ghostty"; BROWSER = "librewolf"; };

  # Appimage support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # QT theming
  qt.enable = true;
  qt.platformTheme = "qt5ct";

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../home/desktop.nix;
    };
  };
}
