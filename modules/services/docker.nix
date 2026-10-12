{vars, ...}: {
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    storageDriver = "btrfs";
  };

  users.users.${vars.user}.extraGroups = ["docker"];
}
