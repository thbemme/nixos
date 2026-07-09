{
  lib,
  pkgs,
  ...
}: {
  programs.fish = {
    shellAliases = {
      r = "${lib.getExe pkgs.nh} os switch --ask $argv";
      u = "${lib.getExe pkgs.nh} os switch --update --ask $argv";
      c = "${lib.getExe pkgs.nh} clean all --keep 5";
    };
  };
}
