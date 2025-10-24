{
  inputs,
  pkgs,
  vars,
  ...
}: {
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
