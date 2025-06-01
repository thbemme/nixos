{
  pkgs,
  vars,
  ...
}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

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
    extraGroups = ["wheel"];
    hashedPassword = "${vars.password}";
    isNormalUser = true;
    shell = pkgs.fish;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  programs.nano.enable = false;

  # Remove extra man pages https://discourse.nixos.org/t/solve-slow-man-cache-the-content-addressed-way-but-not-ca-derivation/58463#p-194464-edit-1-7
  environment.extraSetup =
    /*
    bash
    */
    ''
      find "$out/share/man" \
          -mindepth 1 -maxdepth 1 \
          -not -name "man[1-8]" \
          -exec rm -r "{}" ";"
      rm -r "$out/share/man/man3"
    '';

  security.sudo.wheelNeedsPassword = true;

  environment.variables = {NH_FLAKE = "/home/${vars.user}/git/nixos";};

  programs.fish.enable = true;

  programs.nh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
