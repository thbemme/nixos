{...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      adjust-cell-width = "-10%";
      background-opacity = 0.85;
      confirm-close-surface = false;
      font-family = "Fira Code";
      font-size = 10;
      font-style-bold = "Medium";
      font-style-bold-italic = "Medium Oblique";
      font-style-italic = "Light Oblique";
      font-synthetic-style = false;
      mouse-hide-while-typing = true;
      quit-after-last-window-closed = true;
      shell-integration = "fish";
      theme = "Dracula";
      keybind = [
        "f11=toggle_fullscreen"
        "ctrl+shift+enter=new_split:auto"
        "ctrl+shift+up=resize_split:up,10"
        "ctrl+shift+down=resize_split:down,10"
        "ctrl+shift+right=resize_split:right,10"
        "ctrl+shift+left=resize_split:left,10"
      ];
    };
  };
  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
