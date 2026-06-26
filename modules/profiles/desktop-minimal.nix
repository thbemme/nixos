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
    extraConfig.pipewire = {
      "98-crackling-fix" = {
        "context.properties" = {
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 1024;
          "default.clock.max-quantum" = 8192;
        };
      };
    };
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

  # Kill applications on OOM... prior to the desktop locking up.
  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 20;
    extraArgs = [
      # Avoid killing important system and desktop processes
      "--avoid"
      "^(systemd|kernel|init|dbus|NetworkManager|pipewire)$"
      "--avoid"
      "^(gnome-shell|wayland|niri|dms)$"
      "--avoid"
      "^(gdm|sddm|lightdm|greetd)$"
      # Prefer killing these types of processes first
      "--prefer"
      "^(chrome|chromium|firefox|librewolf|electron)$"
      "--prefer"
      "^(java|node|python|ruby)$"
    ];
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../../home/profiles/desktop-minimal.nix;
    };
  };
}
