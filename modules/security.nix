{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  users.users.user = {
    packages = with pkgs; [
      lynis
      nikto
      nmap
      wapiti
      wireshark
    ];
  };

  programs.wireshark.enable = true;
  users.users.user.extraGroups = [ "wireshark" ];
}
