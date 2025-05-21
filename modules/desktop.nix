{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  imports = [
    ./plymouth.nix
    ./gnome.nix
  ];

  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.systemd.enable = true;
    #kernelPackages = pkgs.linuxPackages_latest;
  };

  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_14.override {
    argsOverride = rec {
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
        sha256 = "sha256-IYF/GZjiIw+B9+T2Bfpv3LBA4U+ifZnCfdsWznSXl6k=";
      };
      version = "6.14.6";
      modDirVersion = "6.14.6";
    };
  });

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
  };

  # Configure console keymap
  console = {
    keyMap = "de-latin1-nodeadkeys";
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  users.users.${vars.user} = {
    packages = with pkgs-unstable; [
      ghostty
    ];
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../home/desktop.nix;
    };
  };

  # List services that you want to enable:
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

  # Disable bluetooth on boot
  hardware.bluetooth.powerOnBoot = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
