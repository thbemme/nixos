{vars, ...}: {
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = ''
      SetEnv TERM=xterm-256color
      User ${vars.sshuser}
    '';
    matchBlocks = {
      "gitlab.com github.com" = {
        user = "git";
      };
    };
  };
}
