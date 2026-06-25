{pkgs, ...}: {
  home.packages = with pkgs; [
    rich-cli
    ouch
  ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    keymap = {
      mgr = {
        prepend_keymap = [
          {
            on = [
              "M"
            ];
            run = "plugin mount";
            desc = "Mount manager";
          }
          {
            on = "F";
            run = "plugin smart-filter";
            desc = "Smart filter";
          }
          {
            on = ["c" "m"];
            run = "plugin chmod";
            desc = "Chmod on selected files";
          }
          {
            on = "<C-d>";
            run = "plugin diff";
            desc = "Diff the selected with the hovered file";
          }
          {
            on = "f";
            run = "plugin jump-to-char";
            desc = "Jump to char";
          }
          {
            on = [
              "g"
              "n"
            ];
            run = "cd ~/git/nixos";
            desc = "Go to nix config";
          }
          {
            on = [
              "g"
              "k"
            ];
            run = "cd ~/kbnetcloud";
            desc = "Go to kbnetcloud";
          }
          {
            on = [
              "g"
              "o"
            ];
            run = "cd ~/Documents";
            desc = "Go to Documents";
          }
          {
            on = [
              "g"
              "p"
            ];
            run = "cd ~/Pictures";
            desc = "Go to Pictures";
          }
          {
            on = "<Enter>";
            run = "plugin smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = ["C"];
            run = "plugin ouch zip";
            desc = "Compress with ouch";
          }
        ];
      };
    };

    plugins = with pkgs.yaziPlugins; {
      inherit chmod;
      inherit diff;
      inherit full-border;
      inherit git;
      inherit jump-to-char;
      inherit mount;
      inherit ouch;
      inherit rich-preview;
      inherit smart-enter;
      inherit smart-filter;
    };

    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
    '';

    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
      };
      extract = [
        {
          run = ''${pkgs.ouch}/bin/ouch d -y "$@" '';
          desc = "Extract here with ouch";
          for = "unix";
        }
      ];
      plugin = {
        prepend_fetchers = [
          {
            url = "*";
            run = "git";
            group = "git";
          }
          {
            url = "*/";
            run = "git";
            group = "git";
          }
        ];
        prepend_previewers = [
          {
            url = "*.{csv,md,json}";
            run = "rich-preview";
          }
          {
            mime = "application/{*zip,x-tar*,x-bzip2,x-7z*,x-rar,x-xz,x-zstd}";
            run = "ouch --archive-icon=''";
          }
        ];
      };
    };
  };
}
