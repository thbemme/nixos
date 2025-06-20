{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  users.users.${vars.user} = {
    packages =
      (with pkgs; [
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
        handbrake
        hexchat
        hunspell
        hunspellDicts.de_DE
        hunspellDicts.en_US
        krita
        libreoffice-fresh
        libsForQt5.qt5ct
        lyx
        nextcloud-client
        nixos-icons
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
      ])
      ++ (with pkgs-unstable; [
        cryptomator
      ]);
  };

  environment.systemPackages = with pkgs; [
    btrfs-assistant
    lm_sensors
  ];

  # Appimage support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # QT theming
  qt.enable = true;
  qt.platformTheme = "qt5ct";

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../home/gui-extras.nix;
    };
  };
}
