{
  lib,
  pkgs,
  ...
}: {
  programs.fish = {
    shellAliases = {
      r = "${lib.getExe pkgs.nh} home switch -c hm --ask";
      c = "nix-collect-garbage -d";
    };
  };
}
