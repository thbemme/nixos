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
        _64gram
        easyeffects
        ffmpeg-full
        gimp3-with-plugins
        handbrake
        hexchat
        krita
        libreoffice-fresh
        libsForQt5.qt5ct
        lyx
        nextcloud-client
        nixos-icons
        pika-backup
        scribus
        stellarium
        tenacity
        texlive.combined.scheme-small
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
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
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
