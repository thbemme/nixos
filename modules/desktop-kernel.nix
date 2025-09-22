{pkgs, ...}: {
  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_zen;
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
}
