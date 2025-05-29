{...}: {
  targets.genericLinux.enable = true;
  imports = [
    ../../home/base.nix
    ../../home/fish.nix
    ../../home/desktop.nix
    ../../home/desktop-software.nix
    ../../home/gnome.nix
    ../../home/home-manager.nix
  ];
}
