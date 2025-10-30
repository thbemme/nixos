{pkgs, ...}: let
  myPackages = import ../modules/packages.nix {inherit pkgs;};
in {
  home.packages = myPackages;
  programs.fish = {
    shellAliases = {
      r = "home-manager switch --flake ~/git/nixos/#hm";
      c = "nix-collect-garbage -d";
    };
  };

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
