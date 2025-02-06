{ pkgs, pkgs-unstable, vars, ... }:

{
  users.users.${vars.user} = {
    packages = (with pkgs; [
      citrix_workspace

    ]) ++
    (with pkgs-unstable; [
      #citrix_workspace
      #teams-for-linux
      alpaca-proxy
    ]);
  };
}
