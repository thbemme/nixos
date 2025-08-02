{
  vars,
  config,
  ...
}: {
  networking.firewall.allowedTCPPorts = [22];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    banner = " _____________
< NixOS on ${config.networking.hostName}, btw! >
 -------------
        \\   ^__^
         \\  (oo)\\_______
            (__)\\       )\\/\\
                ||----w |
                ||     ||

";
    settings = {
      AllowUsers = ["${vars.user}"];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  users.users.${vars.user}.openssh.authorizedKeys.keys = ["${vars.publickey}"];
}
