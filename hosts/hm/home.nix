{...}: {
  targets.genericLinux.enable = true;
  imports = [
    ../../home/base.nix
    ../../home/fish.nix
    ../../home/ghostty.nix
    ../../home/gnome.nix
    ../../home/gui-extras.nix
    ../../home/home-manager.nix
    ../../home/neovim.nix
  ];
}
