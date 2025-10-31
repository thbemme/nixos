{...}: {
  imports = [
    ../apps/fish.nix
    ../apps/git.nix
    ../apps/neovim.nix
    ../apps/ssh.nix
    ../profiles/fish/nixondroid.nix
  ];
  # Read the changelog before changing this value
  home.stateVersion = "24.05";

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
