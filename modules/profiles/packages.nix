{pkgs}:
with pkgs; [
  bat
  coreutils
  curl
  dust
  eza
  fastfetch
  fd
  findutils
  fish
  fishPlugins.fzf-fish
  fishPlugins.grc
  fishPlugins.hydro
  fzf
  git
  git-crypt
  grc
  hostname
  htop
  jq
  killall
  openssh
  openssl
  pv
  q
  ripgrep
  spectre-meltdown-checker
  stress-ng
  wget
  # formatters and linters
  alejandra # nix
  deadnix # nix
  nodePackages.prettier
  shellcheck
  shfmt
  statix # nix
]
