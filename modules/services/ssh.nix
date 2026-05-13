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
      PasswordAuthentication = false;
      PermitEmptyPasswords = false;
      PermitTunnel = false;
      UseDns = false;
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;
      MaxAuthTries = 3;
      MaxSessions = 2;
      ClientAliveInterval = 300;
      ClientAliveCountMax = 0;
      TCPKeepAlive = false;
      AllowTcpForwarding = false;
      AllowAgentForwarding = false;
      LogLevel = "VERBOSE";
      PermitRootLogin = "no";
      KexAlgorithms = [
        # Post-Quantum: https://www.openssh.org/pq.html
        "mlkem768x25519-sha256"
        "sntrup761x25519-sha512"
        "curve25519-sha256@libssh.org"
        "ecdh-sha2-nistp521"
        "ecdh-sha2-nistp384"
        "ecdh-sha2-nistp256"
        "diffie-hellman-group-exchange-sha256"
      ];
      Ciphers = [
        "aes256-gcm@openssh.com"
        "aes128-gcm@openssh.com"
        # stream cipher alternative to aes256, proven to be resilient
        # Very fast on basically anything
        "chacha20-poly1305@openssh.com"
        # industry standard, fast if you have AES-NI hardware
        "aes256-ctr"
        "aes192-ctr"
        "aes128-ctr"
      ];
      Macs = [
        # Combines the SHA-512 hash func with a secret key to create a MAC
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
        "hmac-sha2-512"
        "hmac-sha2-256"
        "umac-128@openssh.com"
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
