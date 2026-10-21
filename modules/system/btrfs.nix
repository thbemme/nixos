{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.fileSystems."/".fsType == "btrfs") {
    services.btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
    };
  };
}
