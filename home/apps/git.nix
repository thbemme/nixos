{vars, ...}: {
  programs.git = {
    enable = true;
    settings = {
      credential.helper = "cache --timeout=36000";
      init.defaultBranch = "main";
      log.date = "iso";
      pull.rebase = true;
      push.autoSetupRemote = true;
      user = {
        name = "${vars.gitName}";
        email = "${vars.gitEmail}";
      };
    };
  };
}
