_: {
  programs.fish = {
    shellInit = "ssh-add -L > /dev/null || ssh-add";
    shellAliases = {
      r = "nh os switch --ask $argv -- --impure";
      u = "nh os switch --update --ask $argv -- --impure";
      c = "nh clean all --keep 5";
    };
  };
}
