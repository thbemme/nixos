# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, lib, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

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

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "dialout" ];
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
      blender-hip
      cryptomator
      easyeffects
      fastfetch
      gimp-with-plugins
      gnome-extension-manager
      gnome.gnome-tweaks
      gpu-viewer
      gnome.seahorse
      gradience
      halloy
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_US
      krita
      libreoffice
      libsForQt5.qt5ct
      lyx
      nextcloud-client
      openshot-qt
      papirus-icon-theme
      papers
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
      wireshark
    ];
    shell = pkgs.fish;
  };

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "user" = import ../home/home.nix;
    };
  };
  # Install firefox and PWA.
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    btrfs-assistant
    clinfo
    dig
    firefoxpwa
    fish
    fishPlugins.done
    fishPlugins.forgit
    fishPlugins.fzf-fish
    fishPlugins.grc
    fishPlugins.hydro
    fzf
    g810-led
    git
    grc
    kitty
    lm_sensors
    motion
    nixpkgs-fmt
    nmap
    pv
    python3
    spectre-meltdown-checker
    stress-ng
    wget
    xsane
    xsensors
  ];

  fonts.packages = with pkgs; [
    inter
    fira-code
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
  networking.firewall.allowedTCPPorts = [ 22 8080 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  programs.fish.enable = true;
  environment.variables = { TERMINAL = "kitty"; BROWSER = "firefox"; FLAKE = "/home/user/git/nixos"; };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.nh.enable = true;

  qt.enable = true;
  qt.platformTheme = "qt5ct";

  services.fwupd.enable = true;

  boot.initrd.systemd.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.plymouth.enable = true;

  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany # web browser
    geary # email client
    pkgs.gnome-console
    pkgs.gnome-connections
  ];
}
