{ pkgs, pkgs-unstable, vars, ... }:

{
  users.users.${vars.user} = {
    packages = (with pkgs; [
      gobuster
      lynis
      nikto
      nmap
      subfinder
      wapiti
      wireshark
    ]) ++
    (with pkgs-unstable; [
      #unstable
    ]);
    extraGroups = [ "wireshark" ];
  };

  programs.wireshark.enable = true;

  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  };

}
