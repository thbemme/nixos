{vars, ...}: {
  programs.git = {
    enable = true;
    userName = "${vars.gitName}";
    userEmail = "${vars.gitEmail}";
    extraConfig = {
      credential.helper = "store";
    };
  };
}
