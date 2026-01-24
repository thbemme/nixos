{...}: {
  imports = [
    ../apps/bat.nix
    ../apps/btop.nix
    ../apps/dconf.nix
    ../apps/fastfetch.nix
    ../apps/fish.nix
    ../apps/ghostty.nix
    ../apps/git.nix
    ../apps/neovim.nix
    ../apps/ssh.nix
    ../themes/theme-cli.nix
    ./base.nix
    ./fish/wsl.nix
  ];
}
