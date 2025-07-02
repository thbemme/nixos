{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.systemd.enable = true;
    #kernelPackages = pkgs.linuxPackages_latest;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Configure keymap in Wayland
  services.xserver = {
    enable = true;
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

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts.monospace = ["Fira Code"];
      defaultFonts.sansSerif = ["Adwaita Sans"];
      defaultFonts.serif = ["Adwaita Serif"];
      defaultFonts.emoji = ["Noto Color Emoji"];
    };
    fontDir.enable = true;
    packages = with pkgs; [
      adwaita-fonts
      fira-code
      noto-fonts
      noto-fonts-color-emoji
      vistafonts
    ];
  };

  # Additional home manager settings
  home-manager = {
    users = {
      "${vars.user}" = import ../home/gui.nix;
    };
  };

  # List services that you want to enable:
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

  # Disable bluetooth on boot
  hardware.bluetooth.powerOnBoot = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
