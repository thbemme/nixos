{
  lib,
  pkgs,
  ...
}: {
  programs.fish = {
    shellInit = "ssh-add -L > /dev/null || ssh-add";
    shellAliases = {
      r = "${lib.getExe pkgs.nh} os switch --ask $argv -- --impure";
      u = "${lib.getExe pkgs.nh} os switch --update --ask $argv -- --impure";
      c = "${lib.getExe pkgs.nh} clean all --keep 5";
    };
  };
}
