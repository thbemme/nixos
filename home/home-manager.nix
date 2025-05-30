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
}
