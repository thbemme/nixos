{...}: {
  targets.genericLinux.enable = true;
  imports = [
    ../../home/base.nix
    ../../home/fish.nix
    ../../home/gui.nix
    ../../home/gui-extras.nix
    ../../home/gnome.nix
    ../../home/home-manager.nix
    ../../home/neovim.nix
  ];
}
