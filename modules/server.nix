{
  inputs,
  pkgs,
  vars,
  ...
}: {
  # Use the GRUB 2 boot loader.
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/vda";
      extraConfig = ''
        serial --unit=0 --speed=115200 --word=8 --parity=no --stop=1
        terminal_input --append serial
        terminal_output --append serial
      '';
    };
    kernelPackages = pkgs.linuxPackages_hardened;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {}).customize {
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [vim-lastplace];
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
        syntax on
        hi Normal guibg=NONE ctermbg=NONE
      '';
    })
    eza
    grc
    htop
    openssl
  ];

  # List services that you want to enable:
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs vars;};
    backupFileExtension = "hm-back";
    users = {
      "${vars.user}" = import ../home/server.nix;
    };
  };
}
