{...}: {
  targets.genericLinux.enable = true;
  imports = [
    ../../home/profiles/home-manager.nix
  ];
}
