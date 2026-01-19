{...}: {
  imports = [
    ../apps/bat.nix
    ../apps/fish.nix
    ../apps/git.nix
    ../apps/neovim.nix
    ../apps/ssh.nix
    ../profiles/fish/nixondroid.nix
  ];

  home.stateVersion = "24.05";

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
