{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  users.users.user = {
    packages = (with pkgs; [
      #teams
      citrix_workspace

    ]) ++
    (with pkgs-unstable; [
      #citrix_workspace
      teams
      alpaca-proxy
    ]);
  };
}
