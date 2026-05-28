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
    man.cache.enable = false;
  };

  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
    HandlePowerKeyLongPress = "poweroff";
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

  # VM tweaks for better responsiveness
  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # Prefer zram, avoid SSD wear
    "vm.dirty_background_ratio" = 5; # Write-back latency optimization
    "vm.dirty_ratio" = 20;
  };

  # Disk schedulers optimized for different storage types
  services.udev.extraRules = ''
    # Set the 'kyber' I/O scheduler for NVMe SSDs. This is optimized for the
    # low latency and high parallelism of modern NVMe drives.
    ACTION=="add|change", KERNEL=="nvme?n?", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="kyber"

    # Set the 'bfq' I/O scheduler for SATA SSDs and rotational HDDs.
    # This scheduler is optimized for desktop responsiveness on these device types.
    ACTION=="add|change", KERNEL=="sd*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
    ACTION=="add|change", KERNEL=="sd*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
  '';
}
