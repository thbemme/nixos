{pkgs, ...}: {
  # Neovim configuration
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
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
    plugins = with pkgs.vimPlugins; [
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
}
