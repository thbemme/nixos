# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, lib, pkgs, inputs, vars, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      ../modules/vim.nix
    ];

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.${vars.user} = {
    isNormalUser = true;
    description = "${vars.user}";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "hm-back";
    users = {
      "${vars.user}" = import ../home/default.nix;
    };
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bat
    bottom
    btop
    clinfo
    coreutils
    curl
    dig
    du-dust
    fastfetch
    fd
    findutils
    fish
    fishPlugins.done
    fishPlugins.done
    fishPlugins.forgit
    fishPlugins.forgit
    fishPlugins.fzf-fish
    fishPlugins.fzf-fish
    fishPlugins.grc
    fishPlugins.grc
    fishPlugins.hydro
    fishPlugins.hydro
    fx
    fzf
    git
    git-crypt
    grc
    htop
    jq
    killall
    mosh
    nixpkgs-fmt
    openssh
    procs
    pv
    ripgrep
    sd
    spectre-meltdown-checker
    stress-ng
    tree
    unzip
    wget
    wget
    zip
    # formatters and linters
    alejandra # nix
    deadnix # nix
    nodePackages.prettier
    shellcheck
    shfmt
    statix # nix
  ];

  fonts.packages = with pkgs; [
    inter
    fira-code
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  programs.fish.enable = true;
  environment.variables = { FLAKE = "/home/${vars.user}/git/nixos"; };

  programs.nh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
