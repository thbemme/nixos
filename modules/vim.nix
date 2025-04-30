{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ((vim_configurable.override { }).customize {
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [
          dracula-vim
          fzf-vim
          fzfWrapper
          minimap-vim
          nerdtree
          rust-vim
          supertab
          vim-airline
          vim-codefmt
          vim-fugitive
          vim-lastplace
          vim-misc
          vim-nix
          vim-signify
        ];
        opt = [ ];
      };
      vimrcConfig.customRC = ''
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
        syntax on
      '';
    })
  ];
  environment.variables = {
    EDITOR = "vim";
  };
}
