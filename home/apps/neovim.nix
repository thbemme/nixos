{pkgs, ...}: {
  # Neovim configuration
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
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
      syntax on
    '';
    plugins = with pkgs.vimPlugins; [
      minimap-vim # Minimap sidebar
      nerdtree # File tree explorer
      nvim-fzf # FZF integration for Neovim
      supertab # Tab completion improvements
      vim-airline # Status/tabline
      vim-fugitive # Git integration
      vim-lastplace # Restore cursor to last edit position
      vim-misc # Misc useful vim utilities
      vim-nix # Nix syntax highlighting and ftplugin
      vim-signify # Show VCS changes in the gutter
    ];
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim -c 'Man!'";
  };
}
