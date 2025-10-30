{...}: {
  targets.genericLinux.enable = true;
  imports = [
    ../../home/profiles/base.nix
    ../../home/apps/fish.nix
    ../../home/ghostty.nix
    ../../home/profiles/gnome.nix
    ../../home/profiles/gui-extras.nix
    ../../home/profiles/home-manager.nix
    ../../home/apps/neovim.nix
  ];
}
