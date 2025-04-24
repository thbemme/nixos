{ vars, ... }:

{
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
  users.users.${vars.user}.openssh.authorizedKeys.keys = [ "${vars.publickey}" ];
}
