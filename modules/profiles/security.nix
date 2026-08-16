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
  ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.${vars.user}.extraGroups = ["wireshark"];

  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  };
}
