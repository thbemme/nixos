{pkgs, ...}: {
  imports = [./kernel-default.nix];

  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Configure console keymap
  console = {
    keyMap = "de-latin1-nodeadkeys";
  };
}
