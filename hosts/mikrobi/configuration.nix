{ config, lib, pkgs, ... }:

{
  # imports =
  #   [
  #     ../../modules/vim.nix
  #   ];

  # Simply install just the packages
  environment.packages = with pkgs; [
    ((vim_configurable.override { }).customize {
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-misc vim-lastplace supertab vim-signify vim-fugitive vim-airline dracula-vim ];
        opt = [ ];
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
    curl
    diffutils
    dig
    fastfetch
    findutils
    fish
    git
    gnupg
    hostname
    htop
    jq
    lynis
    man
    ncurses
    neofetch
    nikto
    nix-index
    nmap
    openssh
    shellcheck
    sudo
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

  # Set your time zone
  #time.timeZone = "Europe/Berlin";

  # Configure home-manager
  home-manager = {
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;

    config =
      { config, lib, pkgs, ... }:
      {
        # Read the changelog before changing this value
        home.stateVersion = "24.05";
        home.file = {
          ".config/fish/config.fish".source = ../../home/dotfiles/mikrobi.fish;
        };
        programs.nix-index = {
          enable = true;
          enableFishIntegration = true;
        };
        programs.git = {
          enable = true;
          userName = "firstname lastname";
          userEmail = "firstname.lastname@maildomain.com";
        };
        programs.ssh = {
          enable = true;
          forwardAgent = true;
          extraConfig = ''
            SetEnv TERM=xterm-256color
          '';
          matchBlocks = {
            "*" = {
              user = "user";
            };
            "blowfish" = {
              hostname = "192.168.178.7";
            };
            "ansible-amd64-vm" = {
              hostname = "192.168.178.23";
            };
            "docker-amd64-vm" = {
              hostname = "192.168.178.18";
            };
            "ssh-amd64-vm" = {
              hostname = "192.168.178.19";
            };
          };
        };
        services.ssh-agent.enable = true;
      };
  };
}
