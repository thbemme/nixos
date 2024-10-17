{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  users.users.user = {
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
