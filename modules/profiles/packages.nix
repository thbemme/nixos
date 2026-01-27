{pkgs}:
with pkgs; [
  coreutils
  curl
  dust
  eza
  fd
  findutils
  fzf
  git
  git-crypt
  gnupg
  grc
  htop
  jq
  killall
  net-tools
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
