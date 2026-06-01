{vars, ...}: {
  # Configure keymap in Wayland
  services.xserver = {
    enable = true;
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
  };

  # Automatic Timezone Daemon
  services.automatic-timezoned.enable = true;

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
  users.users.${vars.user}.extraGroups = ["networkmanager"];

  services.system76-scheduler = {
    enable = true;
    useStockConfig = true;
  };

  # Disable bluetooth on boot
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/desktop-minimal.nix;
    };
  };
}
