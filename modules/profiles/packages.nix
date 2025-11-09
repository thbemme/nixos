{pkgs}:
with pkgs; [
  bat
  coreutils
  curl
  du-dust
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
  gnupg
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
  viddy
  wget
  # formatters and linters
  alejandra # nix
  deadnix # nix
  statix # nix
]
