_: {
  programs.fish = {
    shellAliases = {
      r = "nh home switch -c hm --ask";
      c = "nix-collect-garbage -d";
    };
  };
}
