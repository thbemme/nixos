{
  pkgs,
  inputs,
  vars,
  gpuAcceleration,
  ...
}: {
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  # List services that you want to enable:
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs vars gpuAcceleration;};
    backupFileExtension = "hm-back";
    users = {
      "${vars.user}" = import ../home/server.nix;
    };
  };
}
