{
  pkgs,
  useUnstable,
  ...
}: let
  kernelPackage =
    if useUnstable
    then pkgs.linuxPackages_testing
    else pkgs.linuxPackages_latest;
in {
  imports = [./kernel-default.nix];

  # Bootloader
  boot = {
    initrd.systemd.enable = true;
    kernelPackages = kernelPackage;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.memtest86.enable = true;
    };
  };

  # Configure console keymap
  console = {
    keyMap = "de-latin1-nodeadkeys";
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
  };
}
