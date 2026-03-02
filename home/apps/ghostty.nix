_: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;

    settings = {
      adjust-cell-width = "-10%";
      confirm-close-surface = false;
      focus-follows-mouse = true;
      mouse-hide-while-typing = true;
      quit-after-last-window-closed = true;
      term = "xterm-256color";
      window-decoration = false;
      keybind = [
        "ctrl+shift+down=resize_split:down,10"
        "ctrl+shift+enter=new_split:auto"
        "ctrl+shift+left=resize_split:left,10"
        "ctrl+shift+right=resize_split:right,10"
        "ctrl+shift+up=resize_split:up,10"
        "ctrl+super+down=goto_split:down"
        "ctrl+super+left=goto_split:left"
        "ctrl+super+right=goto_split:right"
        "ctrl+super+up=goto_split:up"
        "f11=toggle_fullscreen"
      ];
    };
  };
  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
