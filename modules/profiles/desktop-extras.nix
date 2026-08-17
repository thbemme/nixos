{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      _64gram
      amberol
      btrfs-assistant
      cozy
      cryptomator
      ffmpeg-full
      gedit
      gimp3-with-plugins
      handbrake
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_US
      krita
      libreoffice-fresh
      lm_sensors
      loupe
      lyx
      nextcloud-client
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
    ])
    ++ (with pkgs-unstable; [
      #_64gram
    ]);

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
