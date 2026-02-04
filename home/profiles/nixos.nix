{...}: {
  imports = [
    ../apps/bat.nix
    ../apps/btop.nix
    ../apps/cava.nix
    ../apps/dconf.nix
    ../apps/fastfetch.nix
    ../apps/fish.nix
    ../apps/git.nix
    ../apps/neovim.nix
    ../apps/ssh.nix
    ../themes/dracula-cli.nix
    ../themes/dracula-gui.nix
    ./base.nix
    ./fish/nixos.nix
  ];
}
