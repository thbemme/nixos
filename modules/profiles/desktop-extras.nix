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
        amberol
        cozy
        cryptomator
        ffmpeg-full
        gedit
        gimp3-with-plugins
        handbrake
        hexchat
        krita
        libreoffice-fresh
        loupe
        lyx
        nextcloud-client
        nixos-icons
        papirus-icon-theme
        papers
        pika-backup
        remmina
        scribus
        stellarium
        tenacity
        texlive.combined.scheme-small
        timg
        tor-browser
        transmission_4-gtk
        vesktop
      ])
      ++ (with pkgs-unstable; [
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

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/desktop-extras.nix;
    };
  };
}
