{
  vars,
  pkgs,
  gpuAcceleration,
  ...
}: {
  imports = [
    ./dconf.nix
  ];
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

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;

  programs.btop = {
    enable = true;
    package =
      if gpuAcceleration
      then pkgs.btop-rocm
      else pkgs.btop;
    settings = {
      color_theme = "dracula";
      theme_background = false;
    };
  };

  programs.fastfetch = {
    enable = true;
  };

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
