{
  vars,
  pkgs,
  gpuAcceleration,
  ...
}: {
  imports = [
    ./fish.nix
    ./fish_nixos.nix
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
    settings = {
      logo = "none";
      display.separator = " | ";
      modules = [
        {
          type = "os";
          key = " OS      ";
          format = "{pretty-name}";
        }
        {
          type = "host";
          key = "󰟀 Host    ";
        }
        {
          type = "uptime";
          key = "󱎫 Uptime  ";
        }
        {
          type = "display";
          key = "󰍹 Display ";
          compactType = "original-with-refresh-rate";
        }
        {
          type = "cpu";
          key = " CPU     ";
          format = "{name}";
        }
        {
          type = "gpu";
          key = "󰢮 GPU     ";
        }
        {
          type = "memory";
          key = " Memory  ";
          format = "{used} / {total}";
        }
        {
          type = "packages";
          key = " Packages";
        }
        {
          type = "wm";
          key = " WM      ";
        }
        {
          type = "shell";
          key = " Shell   ";
        }
        {
          type = "localip";
          key = "󰩟 Local IP";
        }
        {
          type = "colors";
          symbol = "circle";
          key = " Colors  ";
        }
      ];
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
