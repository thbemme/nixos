{
  vars,
  config,
  lib,
  pkgs,
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
    settings = {
      AllowAgentForwarding = false;
      AllowTcpForwarding = false;
      AllowUsers = [vars.user];
      Banner = toString (
        pkgs.writeText "ssh_banner" ''
           ${boxLineTop}
          < ${message} >
           ${boxLineBottom}
                  \   ^__^
                   \  (oo)\_______
                      (__)\       )\/\
                          ||----w |
                          ||     ||

        ''
      );
      ClientAliveCountMax = 0;
      ClientAliveInterval = 300;
      KbdInteractiveAuthentication = lib.mkDefault false;
      LogLevel = "VERBOSE";
      MaxAuthTries = 3;
      MaxSessions = 2;
      PasswordAuthentication = lib.mkDefault false;
      PermitEmptyPasswords = false;
      PermitRootLogin = lib.mkDefault "no";
      PermitTunnel = false;
      TCPKeepAlive = false;
      UseDns = false;
      X11Forwarding = false;

      KexAlgorithms = [
        # Post-Quantum: https://www.openssh.org/pq.html
        "mlkem768x25519-sha256"
        "sntrup761x25519-sha512@openssh.com"
      ];

      Ciphers = [
        "aes256-gcm@openssh.com"
        "chacha20-poly1305@openssh.com"
        "aes256-ctr"
      ];

      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
      ];
    };

    # These keys will be generated for you
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  services.fail2ban = {
    enable = true;
    maxretry = 3;
    bantime = "1h";
    # ignoreIP = [
    # "172.16.0.0/12"
    # "192.168.0.0/16"
    # "2601:881:8100:8de0:31e6:ac52:b5be:462a"
    # "matrix.org"
    # "app.element.io" # don't ratelimit matrix users
    # ];

    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      multipliers = "1 2 4 8 16 32 64 128 256";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
  };

  users.users.${vars.user}.openssh.authorizedKeys.keys = [vars.publickey];
}
