_: {
  programs.fish = {
    shellAliases = {
      r = "home-manager switch --flake ~/git/nixos/#hm";
      c = "nix-collect-garbage -d";
    };
  };
}
