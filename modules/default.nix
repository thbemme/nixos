{ pkgs
, vars
, ...
}: {
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  imports = [
    ./vim.nix
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

  # Define a user account.
  users.users.${vars.user} = {
    description = "${vars.user}";
    extraGroups = [ "wheel" ];
    hashedPassword = "${vars.password}";
    isNormalUser = true;
    shell = pkgs.fish;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bat
    bottom
    clinfo
    coreutils
    curl
    dig
    du-dust
    eza
    fastfetch
    fd
    findutils
    fish
    fishPlugins.done
    fishPlugins.forgit
    fishPlugins.fzf-fish
    fishPlugins.grc
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
    vistafonts
  ];

  security.sudo.wheelNeedsPassword = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  programs.nano.enable = false;

  programs.fish.enable = true;
  environment.variables = { FLAKE = "/home/${vars.user}/git/nixos"; };
  environment.shellAliases = {
    eza = "eza --group-directories-first";
    l = "eza -laF";
    ls = "eza -F";
    grrrr = "git reset --hard";
    gs = "git status";
    mkdir = "mkdir -p";
  };
  programs.nh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
