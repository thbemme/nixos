{ config, lib, pkgs, pkgs-unstable, inputs, vars, ... }:

{
  users.users.${vars.user} = {
    packages = (with pkgs; [
      teams-for-linux
      citrix_workspace

    ]) ++
    (with pkgs-unstable; [
      #citrix_workspace
      #teams-for-linux
      alpaca-proxy
    ]);
  };
}
