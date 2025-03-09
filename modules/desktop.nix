{ pkgs, pkgs-unstable, inputs, vars, ... }:

{

  imports =
    [
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

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    wideArea = false;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  hardware.sane.enable = true; # enables support for SANE scanners
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  };

  users.users.${vars.user} = {
    extraGroups = [ "networkmanager" "scanner" "lp" "dialout" ];
    packages = (with pkgs; [
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })
      easyeffects
      fastfetch
      ffmpeg-full
      gimp-with-plugins
      gpu-viewer
      hexchat
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_US
      krita
      libreoffice
      libsForQt5.qt5ct
      lyx
      nextcloud-client
      openshot-qt
      oreo-cursors-plus
      paper-plane
      papirus-icon-theme
      phoronix-test-suite
      pika-backup
      revolt-desktop
      stellarium
      tor-browser
      transmission_4-gtk
      vlc
      vscodium
      whatsapp-for-linux
    ]) ++
    (with pkgs-unstable; [
      cryptomator
      ghostty
      handbrake
    ]);
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../home/desktop.nix;
    };
  };

  programs.firefox = {
    enable = true;
    package = pkgs-unstable.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
        "cookiebanners.service.mode" = 2; # Block cookie banners
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    btrfs-assistant
    lm_sensors
    xsane
    xsensors
  ];

  # List services that you want to enable:

  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  environment.variables = { TERMINAL = "ghostty"; BROWSER = "librewolf"; };

  # Appimage support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # QT theming
  qt.enable = true;
  qt.platformTheme = "qt5ct";

  # Enable firmware service
  services.fwupd.enable = true;

}
