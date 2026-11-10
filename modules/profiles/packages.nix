{pkgs}:
with pkgs; [
  # core system
  coreutils
  findutils
  procps
  killall
  openssh
  openssl

  # shell / navigation
  fzf
  fd
  eza

  # text / search
  ripgrep
  jq
  q

  # git
  git
  git-crypt
  lazygit

  # files / disk
  dfc
  dust
  pv

  # system monitoring
  htop
  pfetch-rs
  viddy

  # network
  curl
  wget

  # security / crypto
  gnupg
  spectre-meltdown-checker

  # stress testing
  stress-ng

  # colorizers
  grc

  # formatters and linters
  alejandra # nix
  deadnix # nix
  statix # nix
]
