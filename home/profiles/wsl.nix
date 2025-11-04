{...}: {
  imports = [
    ./base.nix
    ./fish/wsl.nix
    ../apps/btop.nix
    ../apps/dconf.nix
    ../apps/fish.nix
    ../apps/ghostty.nix
    ../apps/git.nix
    ../apps/neovim.nix
    ../apps/ssh.nix
  ];
}
