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
    };
  };

}
