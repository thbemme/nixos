{ pkgs, vars, ... }:

{

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  users.users.${vars.user} = {
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      alsa-utils
      amberol
      gnome-tweaks
      papers
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
      "${vars.user}" = import ../home/gnome.nix;
    };
  };

}
