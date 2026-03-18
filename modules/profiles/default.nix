{
  pkgs,
  vars,
  ...
}: let
  defaultPackages = import ./packages.nix {inherit pkgs;};
in {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["@wheel"];
    };
  };

  environment.systemPackages = defaultPackages;

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

  # Define a user account.
  users.users.${vars.user} = {
    description = "${vars.user}";
    extraGroups = ["wheel"];
    hashedPassword = "${vars.password}";
    isNormalUser = true;
    shell = pkgs.fish;
  };

  system.stateVersion = "24.05";

  programs = {
    command-not-found.enable = false;
    fish.enable = true;
    nano.enable = false;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d";
      flake = "/home/${vars.user}/git/nixos/";
    };
  };

  security.sudo.wheelNeedsPassword = true;

  # faster eval time
  documentation = {
    nixos.enable = false;
    man.generateCaches = false;
  };

  environment.variables = {
    EDITOR = "vim";
    SYSTEMD_EDITOR = "vim";
    VISUAL = "vim";
  };

  services.journald.extraConfig = "SystemMaxUse=1G";
  systemd.coredump.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
