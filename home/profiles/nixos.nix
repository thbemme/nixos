{...}: {
  imports = [
    ./base.nix
    ./theme-cli.nix
    ./theme-gui.nix
    ../apps/bat.nix
    ../apps/btop.nix
    ../apps/cava.nix
    ../apps/dconf.nix
    ../apps/fish.nix
    ../apps/git.nix
    ../apps/neovim.nix
    ../apps/ssh.nix
    ../profiles/fish/nixos.nix
  ];
}
