# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      # Include the results of the hardware scan.
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
    memoryPercent = 25;
  };

  hardware.sane.enable = true; # enables support for SANE scanners
  #hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  };

  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

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
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "gamemode" "dialout" ];
    packages = with pkgs; [
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })
      adwsteamgtk
      amberol
      citrix_workspace
      cryptomator
      discord
      ecwolf
      fastfetch
      furmark
      gimp-with-plugins
      gnome-extension-manager
      gnome.seahorse
      gpt4all
      gradience
      gzdoom
      halloy
      krita
      libsForQt5.qt5ct
      lutris
      lyx
      mangohud
      nextcloud-client
      openshot-qt
      papirus-icon-theme
      phoronix-test-suite
      pika-backup
      protonup-qt
      remmina
      scummvm
      stellarium
      telegram-desktop
      thonny
      tor-browser
      transmission_4-gtk
      vlc
      vscodium
      whatsapp-for-linux
      wireshark
      wowup-cf
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
  # Enable automatic login for the user.
  # services.displayManager.autoLogin.user = "user";
  # services.xserver.displayManager.autoLogin.user = "user";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

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
    ((vim_configurable.override { }).customize {
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace dracula-vim ];
        opt = [ ];
      };
      vimrcConfig.customRC = ''
        set backspace=indent,eol,start
        set expandtab
        set history=100
        set hlsearch
        set ignorecase
        set number
        set shiftround
        set shiftwidth=2
        set tabstop=2
        set wildmenu
        syntax on
      '';
    })
    blender-hip
    btop
    btrfs-assistant
    clinfo
    corectrl
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
    gnome.gnome-boxes
    gnome.gnome-tweaks
    gpu-viewer
    grc
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    kitty
    libreoffice
    lm_sensors
    motion
    nixpkgs-fmt
    nmap
    python3
    qemu
    spectre-meltdown-checker
    stress-ng
    vulkan-tools
    wineWowPackages.staging
    winetricks
    wget
    xsane
    xsensors
    #zed-editor
  ];

  systemd.tmpfiles.rules =
    let
      firmware =
        pkgs.runCommandLocal "qemu-firmware" { } ''
          mkdir $out
          cp ${pkgs.qemu}/share/qemu/firmware/*.json $out
          substituteInPlace $out/*.json --replace ${pkgs.qemu} /run/current-system/sw
        '';
    in
    [ "L+ /var/lib/qemu/firmware - - - - ${firmware}" ];

  fonts.packages = with pkgs; [
    commit-mono
    inter
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.gamemode.enable = true;

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
  networking.firewall.allowedTCPPorts = [ 22 8081 ];
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
  environment.variables = { EDITOR = "vim"; TERMINAL = "kitty"; BROWSER = "firefox"; FLAKE = "/home/user/git/nixos"; };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.nh.enable = true;

  qt.enable = true;
  qt.platformTheme = "qt5ct";

  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany # web browser
    geary # email client
    pkgs.gnome-console
    pkgs.gnome-connections
  ];

  # Corectrl without password
  security.polkit = {
    extraConfig = ''
      polkit.addRule(function(action, subject) {
          if ((action.id == "org.corectrl.helper.init" ||
               action.id == "org.corectrl.helperkiller.init") &&
              subject.local == true &&
              subject.active == true &&
              subject.isInGroup("wheel")) {
                  return polkit.Result.YES;
          }
      });
    '';
  };
}
