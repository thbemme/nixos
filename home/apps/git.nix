{vars, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "${vars.gitName}";
        email = "${vars.gitEmail}";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      extraConfig = {
        credential.helper = "store";
      };
    };
  };
}
