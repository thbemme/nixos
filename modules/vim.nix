{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
  ];
  environment.variables = {
    EDITOR = "vim";
  };
}
