{ pkgs, pkgs-unstable, vars, ... }:

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
      libreoffice-fresh
      libsForQt5.qt5ct
      lyx
      nextcloud-client
      openshot-qt
      paper-plane
      phoronix-test-suite
      pika-backup
      revolt-desktop
      scribus
      stellarium
      tenacity
      tor-browser
      transmission_4-gtk
      vesktop
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
      "${vars.user}" = import ../home/desktop-software.nix;
    };
  };


}
