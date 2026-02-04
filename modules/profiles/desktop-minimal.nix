{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: let
  fonts = import ./fonts.nix {inherit pkgs;};
in {
  # Configure keymap in Wayland
  services.xserver = {
    enable = true;
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
  };

  # Automatic Timezone Daemon
  services.automatic-timezoned.enable = true;

  users.users.${vars.user} = {
    extraGroups = ["networkmanager"];
    packages = with pkgs-unstable; [
      ghostty
    ];
  };

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

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["FiraCode Nerd Font"];
        sansSerif = ["Adwaita Sans"];
        serif = ["Adwaita Serif"];
        emoji = ["Noto Color Emoji"];
      };
    };
    fontDir.enable = true;
    packages = fonts;
  };

  services.system76-scheduler = {
    enable = true;
    useStockConfig = true;
  };

  # Disable bluetooth on boot
  hardware.bluetooth.powerOnBoot = false;

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/desktop-minimal.nix;
    };
  };
}
