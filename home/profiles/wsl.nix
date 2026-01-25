{...}: {
  imports = [
    ./base.nix
    ./theme-cli.nix
    ./fish/wsl.nix
    ../apps/dconf.nix
    ../apps/bat.nix
    ../apps/btop.nix
    ../apps/fish.nix
    ../apps/ghostty.nix
    ../apps/git.nix
    ../apps/neovim.nix
    ../apps/ssh.nix
  ];
}
