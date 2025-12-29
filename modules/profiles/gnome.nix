{
  pkgs,
  vars,
  ...
}: {
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  users.users.${vars.user} = {
    extraGroups = ["networkmanager"];
    packages = with pkgs; [
      alsa-utils
      amberol
      gnome-tweaks
      oreo-cursors-plus
      papirus-icon-theme
      remmina
      seahorse
      soundconverter
    ];
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany # web browser
    geary # email client
    gnome-connections
    gnome-console
  ];

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/gnome.nix;
    };
  };
}
