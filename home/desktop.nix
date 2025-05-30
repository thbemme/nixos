{pkgs, ...}: {
  home.file = {
    ".config/ghostty/config".source = ./dotfiles/ghostty;
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
