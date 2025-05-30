{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  imports = [
    ./plymouth.nix
    ./gnome.nix
  ];

  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Configure keymap in Wayland
  services.xserver = {
    enable = true;
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
  };

  # Configure console keymap
  console = {
    keyMap = "de-latin1-nodeadkeys";
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  users.users.${vars.user} = {
    packages = with pkgs-unstable; [
      ghostty
    ];
  };

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
        "cookiebanners.service.mode" = 2; # Block cookie banners
        "network.cookie.lifetimePolicy" = 0;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = false;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "webgl.disabled" = false;
      };
      ExtensionSettings = {
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        "vimium-c@gdh1995.cn" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
          installation_mode = "force_installed";
        };
        "authenticator@mymindstorm" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/auth-helper/latest.xpi";
          installation_mode = "force_installed";
        };
        "FirefoxColor@mozilla.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
          installation_mode = "force_installed";
        };
        "idcac-pub@guus.ninja" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  fonts.packages = with pkgs; [
    adwaita-fonts
    fira-code
    vistafonts
  ];

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../home/desktop.nix;
    };
  };

  # List services that you want to enable:
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

  # Disable bluetooth on boot
  hardware.bluetooth.powerOnBoot = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
