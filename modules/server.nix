{
  inputs,
  pkgs,
  vars,
  ...
}: {
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
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
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [nvim-lastplace];
      };
    };
  };

  environment = {
    variables = {
      EDITOR = "vim";
      SYSTEMD_EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  # List services that you want to enable:
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

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
