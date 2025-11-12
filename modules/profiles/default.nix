{
  pkgs,
  vars,
  ...
}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["@wheel"];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

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

  programs.nano.enable = false;
  programs.command-not-found.enable = false;

  security.sudo.wheelNeedsPassword = true;

  # faster eval time
  documentation.nixos.enable = false;
  documentation.man.generateCaches = false;

  environment.variables = {
    NH_FLAKE = "/home/${vars.user}/git/nixos";
    EDITOR = "vim";
    SYSTEMD_EDITOR = "vim";
    VISUAL = "vim";
  };

  services.journald.extraConfig = "SystemMaxUse=1G";
  systemd.coredump.enable = false;

  programs.fish.enable = true;

  programs.nh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
