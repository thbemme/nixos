{pkgs, ...}: let
  myPackages = import ../../modules/profiles/packages.nix {inherit pkgs;};
in {
  imports = [
    ../../home/apps/bat.nix
    ../../home/apps/btop.nix
    ../../home/apps/dconf.nix
    ../../home/apps/fish.nix
    ../../home/apps/git.nix
    ../../home/apps/neovim.nix
    ../../home/apps/ssh.nix
    ../../home/profiles/base.nix
    ../../home/profiles/fish/home-manager.nix
    ../../home/profiles/gaming.nix
    ../../home/profiles/gnome.nix
    ../../home/profiles/gui-extras.nix
    ../../home/profiles/gui-minimal.nix
  ];

  home.packages = myPackages;

  programs.nh.enable = true;

  # Setup fish shell via bash hook
  programs.bash = {
    enable = true;
    package = null;
    bashrcExtra = ''
      if [[ $($(command -v ps) --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec $(command -v fish) $LOGIN_OPTION
      fi
    '';
  };
}
