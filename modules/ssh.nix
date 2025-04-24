{ vars, ... }:

{
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "${vars.user}" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  users.users.${vars.user}.openssh.authorizedKeys.keys = [ "${vars.publickey}" ];
}
