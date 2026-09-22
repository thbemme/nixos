{vars, ...}: {
  programs.git = {
    enable = true;
    settings = {
      credential.helper = "cache --timeout=36000";
      init.defaultBranch = "main";
      log.date = "iso";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      rerere = {
        autoupdate = true;
        enabled = true;
      };
      user = {
        name = "${vars.gitName}";
        email = "${vars.gitEmail}";
      };
    };
  };
}
