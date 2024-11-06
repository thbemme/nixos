{ config, lib, pkgs, pkgs-unstable, inputs, vars, ... }:

{
  users.users.${vars.user} = {
    packages = with pkgs; [
      lynis
      nikto
      nmap
      wapiti
      wireshark
    ];
    extraGroups = [ "wireshark" ];
  };

  programs.wireshark.enable = true;

  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  };

}
