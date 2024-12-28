# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, lib, pkgs, pkgs-unstable, inputs, vars, ... }:

{

  imports =
    [
      ./plymouth.nix
      ./gnome.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;


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
      firefoxpwa
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
      papirus-icon-theme
      phoronix-test-suite
      pika-backup
      stellarium
      telegram-desktop
      tor-browser
      transmission_4-gtk
      vesktop
      vlc
      vscodium
      whatsapp-for-linux
    ]) ++
    (with pkgs-unstable; [
      cryptomator
    ]) ++
    (with inputs; [
      ghostty.packages.x86_64-linux.default
    ]);
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
    g810-led
    lm_sensors
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

  environment.variables = { TERMINAL = "ghotty"; BROWSER = "firefox"; };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Appimage support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # QT theming
  qt.enable = true;
  qt.platformTheme = "qt5ct";

  # Enable firmware service
  services.fwupd.enable = true;

}
