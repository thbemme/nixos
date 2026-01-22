{pkgs}:
with pkgs; [
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
  fzf
  git
  git-crypt
  gnupg
  grc
  hostname
  htop
  jq
  killall
  ncurses
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
