_: {
  programs.fish = {
    shellAliases = {
      r = "nh os switch --ask $argv";
      u = "nh os switch --update --ask $argv";
      c = "nh clean all --keep 5";
    };
  };
}
