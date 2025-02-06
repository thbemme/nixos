{ pkgs, pkgs-unstable, vars, ... }:

{
  users.users.${vars.user} = {
    packages = (with pkgs; [
      gobuster
      nmap
      subfinder
      wireshark
    ]) ++
    (with pkgs-unstable; [
      lynis
      nikto
      wapiti
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
