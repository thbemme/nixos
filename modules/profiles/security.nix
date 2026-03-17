{
  pkgs,
  vars,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gobuster
    lynis
    nikto
    nmap
    ssh-audit
    subfinder
    #wapiti
    wireshark
  ];

  users.users.${vars.user}.extraGroups = ["wireshark"];

  programs.wireshark.enable = true;

  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  };
}
