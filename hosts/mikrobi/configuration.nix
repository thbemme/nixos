{
  lib,
  pkgs,
  vars,
  ...
}: {
  environment.packages = with pkgs; [
    ((vim_configurable.override {}).customize {
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [vim-nix vim-misc vim-lastplace supertab vim-signify vim-fugitive vim-airline dracula-vim];
        opt = [];
      };
      vimrcConfig.customRC = ''
        set backspace=indent,eol,start
        set expandtab
        set history=100
        set hlsearch
        set ignorecase
        set number
        set shiftround
        set shiftwidth=2
        set tabstop=2
        set wildmenu
        color dracula
        syntax on
        hi Normal guibg=NONE ctermbg=NONE
      '';
    })
    alejandra
    bat
    curl
    diffutils
    dig
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
    lynis
    man
    ncurses
    nikto
    nix-index
    nmap
    openssh
    openssl
    ripgrep
    shellcheck
    tzdata
    utillinux
    wapiti
  ];

  environment.extraOutputsToInstall = [
    "doc"
    "info"
    "devdoc"
  ];
  environment.motd = null;

  user.shell = "${lib.getExe pkgs.fish}";

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  networking.hosts = {
    "192.168.178.5" = ["pita"];
    "192.168.178.6" = ["pihole-amd64-vm"];
    "192.168.178.7" = ["blowfish"];
    "192.168.178.9" = ["debian"];
    "192.168.178.14" = ["nginx-amd64-vm"];
    "192.168.178.15" = ["mail" "mail-amd64-vm"];
    "192.168.178.17" = ["medium-amd64-vm"];
    "192.168.178.18" = ["docker-amd64-vm"];
    "192.168.178.19" = ["ssh-amd64-vm"];
    "192.168.178.20" = ["puffy"];
    "192.168.178.23" = ["ansible-amd64-vm"];
  };

  # Set your time zone
  #time.timeZone = "Europe/Berlin";

  # Configure home-manager
  home-manager = {
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit vars;
    };
    config = ../../home/nixondroid.nix;
  };
}
