{
  vars,
  useUnstable,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "${vars.user}";
    homeDirectory = "/home/${vars.user}";
    enableNixpkgsReleaseCheck = !useUnstable;
    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
}
