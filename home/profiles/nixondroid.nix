{vars, ...}: {
  imports = [
    ../apps/fish.nix
    ../apps/neovim.nix
  ];
  # Read the changelog before changing this value
  home.stateVersion = "24.05";

  programs.fish = {
    shellInit = "set -Ux fish_features no-keyboard-protocols";
    shellAliases = {
      r = "nix-on-droid switch -F ~/git/nixos/ $argv";
      c = "nix-collect-garbage -d";
    };
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.git = {
    enable = true;
    userName = "${vars.gitName}";
    userEmail = "${vars.gitEmail}";
  };
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = ''
      SetEnv TERM=xterm-256color
    '';
    matchBlocks = {
      "*" = {
        user = "${vars.user}";
      };
    };
  };
}
