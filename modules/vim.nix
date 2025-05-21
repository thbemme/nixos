{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        nmap <silent> <F2> :NERDTreeFind<CR>
        nmap <space>e :NERDTreeToggle %:p:h<CR>
        nmap <space>m :MinimapToggle<CR>
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
        let g:dracula_colorterm = 0
        colorscheme dracula
        syntax on
        hi Normal guibg=NONE ctermbg=NONE
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          dracula-nvim
          minimap-vim
          nerdtree
          nvim-fzf
          rust-vim
          supertab
          vim-airline
          vim-fugitive
          vim-lastplace
          vim-misc
          vim-nix
          vim-signify
        ];
      };
    };
  };
  environment.variables = {
    EDITOR = "nvim";
  };
}
