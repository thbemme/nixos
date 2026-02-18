{pkgs, ...}: let
  myPackages = import ../../modules/profiles/packages.nix {inherit pkgs;};
in {
  imports = [
    ../apps/bat.nix
    ../apps/btop.nix
    ../apps/dconf.nix
    ../apps/fastfetch.nix
    ../apps/fish.nix
    ../apps/git.nix
    ../apps/neovim.nix
    ../apps/ssh.nix
    ../profiles/stylix.nix
    ./base.nix
    ./desktop-extras.nix
    ./desktop-gnome.nix
    ./desktop-minimal.nix
    ./fish/home-manager.nix
    ./gaming.nix
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
