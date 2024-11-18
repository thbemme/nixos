# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, lib, pkgs, inputs, vars, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.plymouth.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  hardware.sane.enable = true; # enables support for SANE scanners
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  };

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

  users.users.${vars.user} = {
    extraGroups = [ "networkmanager" "scanner" "lp" "dialout" ];
    packages = with pkgs; [
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })
      alsa-utils
      amberol
      apostrophe
      cryptomator
      easyeffects
      fastfetch
      gimp-with-plugins
      gnome-extension-manager
      gnome.gnome-tweaks
      gnome.seahorse
      gpu-viewer
      gradience
      halloy
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_US
      jq
      krita
      libreoffice
      libsForQt5.qt5ct
      lyx
      nextcloud-client
      openshot-qt
      papers
      papirus-icon-theme
      phoronix-test-suite
      pika-backup
      remmina
      stellarium
      telegram-desktop
      tor-browser
      transmission_4-gtk
      vesktop
      vlc
      vscodium
      whatsapp-for-linux
    ];
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../home/desktop.nix;
    };
  };

  # Install firefox and PWA.
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btrfs-assistant
    firefoxpwa
    g810-led
    kitty
    lm_sensors
    motion
    xsane
    xsensors
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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

  environment.variables = { TERMINAL = "kitty"; BROWSER = "firefox"; };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Appimage support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # QT theming
  qt.enable = true;
  qt.platformTheme = "qt5ct";

  # Enable firmware service
  services.fwupd.enable = true;

  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany # web browser
    geary # email client
    pkgs.gnome-console
    pkgs.gnome-connections
  ];

}
