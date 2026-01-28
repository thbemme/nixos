{
  pkgs,
  vars,
  ...
}: {
  # Enable the GNOME Desktop Environment.
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  users.users.${vars.user} = {
    packages = with pkgs; [
      alsa-utils
      gnome-tweaks
      seahorse
      soundconverter
    ];
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany # web browser
    geary # email client
    gnome-connections
    gnome-console
    gnome-music
    gnome-tour
  ];

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/desktop-gnome.nix;
    };
  };
}
