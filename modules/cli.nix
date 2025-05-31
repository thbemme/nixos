{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    bottom
    clinfo
    coreutils
    curl
    dig
    du-dust
    dysk
    eza
    fd
    findutils
    fish
    fishPlugins.fzf-fish
    fishPlugins.grc
    fishPlugins.hydro
    fx
    fzf
    git
    git-crypt
    grc
    htop
    jq
    killall
    mosh
    openssh
    openssl
    procs
    pv
    ripgrep
    sd
    spectre-meltdown-checker
    stress-ng
    tealdeer
    tree
    unzip
    wget
    zip
    # formatters and linters
    alejandra # nix
    deadnix # nix
    nodePackages.prettier
    shellcheck
    shfmt
    statix # nix
  ];
  programs.fish.enable = true;
}
