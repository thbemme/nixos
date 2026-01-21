_: {
  # Ensure Home Manager manages the config file
  home = {
    file.".config/ghostty/config".text = ''
      adjust-cell-width = -10%
      background-opacity = 0.850000
      confirm-close-surface = false
      font-family = Fira Code
      font-size = 10
      font-style-bold = Medium
      font-style-bold-italic = Medium Oblique
      font-style-italic = Light Oblique
      font-synthetic-style = false
      keybind = ctrl+shift+down=resize_split:down,10
      keybind = ctrl+shift+enter=new_split:auto
      keybind = ctrl+shift+left=resize_split:left,10
      keybind = ctrl+shift+right=resize_split:right,10
      keybind = ctrl+shift+up=resize_split:up,10
      keybind = ctrl+super+down=goto_split:down
      keybind = ctrl+super+left=goto_split:left
      keybind = ctrl+super+right=goto_split:right
      keybind = ctrl+super+up=goto_split:up
      keybind = f11=toggle_fullscreen
      mouse-hide-while-typing = true
      quit-after-last-window-closed = true
      shell-integration = fish
      theme = Dracula
    '';
    sessionVariables = {
      TERMINAL = "ghostty";
    };
  };
}
