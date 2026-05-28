{vars, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        ForwardAgent = true;
        SetEnv.TERM = "xterm-256color";
        User = "${vars.sshuser}";
      };
      "gitlab.com github.com" = {
        User = "git";
      };
      "test-amd64-vm dev-amd64-vm [127.0.0.1]:2222" = {
        UserKnownHostsFile = "/dev/null";
      };
    };
  };
}
