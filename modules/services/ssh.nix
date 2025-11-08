{
  vars,
  config,
  lib,
  ...
}: let
  hostname = config.networking.hostName;
  message = "NixOS on ${hostname}, btw!";
  boxLineTop = lib.concatStrings (lib.replicate (lib.stringLength message + 2) "_");
  boxLineBottom = lib.concatStrings (lib.replicate (lib.stringLength message + 2) "-");
in {
  networking.firewall.allowedTCPPorts = [22];

  services.openssh = {
    enable = true;
    banner = ''
       ${boxLineTop}
      < ${message} >
       ${boxLineBottom}
              \   ^__^
               \  (oo)\_______
                  (__)\       )\/\
                      ||----w |
                      ||     ||
    '';
    settings = {
      AllowUsers = [vars.user];
      #KbdInteractiveAuthentication = false;
      #PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.${vars.user}.openssh.authorizedKeys.keys = [vars.publickey];
}
