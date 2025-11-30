{vars, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = true;
        setEnv.TERM = "xterm-256color";
        user = "${vars.sshuser}";
      };
      "gitlab.com github.com" = {
        user = "git";
      };
      "test-amd64-vm dev-amd64-vm [127.0.0.1]:2222" = {
        userKnownHostsFile = "/dev/null";
      };
    };
  };
}
