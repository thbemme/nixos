{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    configure = {
      # Add transparent.nvim plugin
      extraPlugins = with pkgs.vimPlugins; {
        transparent = {
          package = transparent-nvim;
          # The setup must be a string containing Lua code
          setup = ''
            require('transparent').setup({
              enable = true,  -- Automatically enable transparency

              groups = {
                "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
                "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
                "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
                "SignColumn", "CursorLine", "CursorLineNr", "EndOfBuffer"
              },
              extra_groups = {},
              exclude_groups = {},
            })
          '';
        };
      };
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
        colorscheme dracula
        syntax on
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          dracula-nvim
          minimap-vim
          nerdtree
          nvim-fzf
          rust-vim
          supertab
          transparent-nvim
          vim-airline
          vim-codefmt
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
