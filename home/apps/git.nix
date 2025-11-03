{vars, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "${vars.gitName}";
      user.email = "${vars.gitEmail}";
      extraConfig = {
        credential.helper = "store";
      };
    };
  };

}
