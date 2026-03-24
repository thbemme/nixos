{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

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
            desc = "Go to documents";
          }
          {
            on = [
              "g"
              "p"
            ];
            run = "cd ~/Pictures";
            desc = "Go to kbnetcloud";
          }
          {
            on = "<Enter>";
            run = "plugin smart-enter";
            desc = "Enter the child directory, or open the file";
          }
        ];
      };
    };

    plugins = with pkgs.yaziPlugins; {
      "smart-enter" = smart-enter;
      "full-border" = full-border;
      "mount" = mount;
      "smart-filter" = smart-filter;
      "chmod" = chmod;
      "diff" = diff;
      "git" = git;
      "jump-to-char" = jump-to-char;
    };

    initLua = ''
      require("full-border"):setup()
    '';

    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
      };
      plugin = {
        prepend_previewers = [
          {
            url = "*.csv";
            run = "rich-preview";
          }
          {
            url = "*.md";
            run = "rich-preview";
          }
          {
            url = "*.json";
            run = "rich-preview";
          }
        ];
      };
    };
  };
}
