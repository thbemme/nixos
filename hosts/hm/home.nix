{...}: {
  targets.genericLinux.enable = true;
  imports = [
    ../../home/apps/bat.nix
    ../../home/apps/btop.nix
    ../../home/apps/codium.nix
    ../../home/apps/dconf.nix
    ../../home/apps/fish.nix
    ../../home/apps/ghostty.nix
    ../../home/apps/git.nix
    ../../home/apps/mangohud.nix
    ../../home/apps/neovim.nix
    ../../home/apps/ssh.nix
    ../../home/profiles/base.nix
    ../../home/profiles/fish/home-manager.nix
    ../../home/profiles/gnome.nix
    ../../home/profiles/gui-extras.nix
    ../../home/profiles/home-manager.nix
  ];
}
