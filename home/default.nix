{ config, pkgs, inputs, vars, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${vars.user}";
  home.homeDirectory = "/home/${vars.user}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through "home.file".
  home.file = {
    ".config/fish/config.fish".source = ./dotfiles/default.fish;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "dracula";
      theme_background = false;
    };
  };

  programs.git = {
    enable = true;
    userName = "${vars.gitName}";
    userEmail = "${vars.gitEmail}";
    extraConfig = {
      credential.helper = "store";
    };
  };
}
