{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [
            "g"
            "n"
          ];
          run = "cd ~/git/nixos";
          desc = "go to nix config";
        }
        {
          on = "<Enter>";
          run = "plugin smart-enter";
          desc = "Enter the child directory, or open the file";
        }
      ];
    };

    plugins = with pkgs.yaziPlugins; {
      "smart-enter" = smart-enter;
      "full-border" = full-border;
    };

    initLua = ''
      require("full-border"):setup()
    '';

    settings = {
      mgr = {
        show_hidden = true;
        sort_dir_first = true;
      };
    };
  };
}
