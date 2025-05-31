{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    du-dust
    dysk
    eza
    fd
    fx
    fzf
    grc
    mosh
    oreo-cursors-plus
    papirus-icon-theme
    procs
    pv
    ripgrep
    sd
    tealdeer
    # formatters and linters
    alejandra # nix
    deadnix # nix
    nodePackages.prettier
    shellcheck
    shfmt
    statix # nix
  ];
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
