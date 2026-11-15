{config, ...}: let
  inherit
    (config.lib.niri.actions)
    clear-dynamic-cast-target
    close-window
    consume-or-expel-window-left
    consume-or-expel-window-right
    expand-column-to-available-width
    focus-column-first
    focus-column-last
    focus-column-right
    focus-monitor-down
    focus-monitor-left
    focus-monitor-right
    focus-monitor-up
    focus-window-or-workspace-down
    focus-window-or-workspace-up
    focus-workspace-down
    focus-workspace-up
    fullscreen-window
    maximize-column
    move-column-left
    move-column-right
    move-column-to-monitor-left
    move-column-to-monitor-right
    move-column-to-workspace-down
    move-column-to-workspace-up
    move-window-down
    move-window-up
    move-workspace-to-monitor-next
    set-dynamic-cast-monitor
    set-dynamic-cast-window
    spawn
    switch-focus-between-floating-and-tiling
    switch-preset-window-height
    switch-preset-window-width
    toggle-column-tabbed-display
    toggle-keyboard-shortcuts-inhibit
    toggle-overview
    ;
in {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    ### Launchers & apps
    "Mod+Return".action = spawn "ghostty";
    "Mod+b".action = spawn "librewolf";
    "Mod+Shift+b".action = spawn "tor-browser";
    "Mod+n".action = spawn "nautilus";
    "Mod+Shift+n".action = spawn "ghostty" "-e" "yazi";
    "Mod+v".action = spawn "dms" "ipc" "notepad" "toggle";
    "Mod+Shift+v".action = spawn "ghostty" "-e" "nvim";
    "Mod+c".action = spawn "dcal" "toggle";
    "Mod+Shift+l".action = spawn "loginctl" "lock-session";
    "Ctrl+Alt+Delete".action = spawn "dms" "ipc" "powermenu" "toggle";

    "Menu" = {
      action = spawn "dms" "ipc" "launcher" "toggle";
      repeat = false;
    };
    "Mod" = {
      release = spawn "dms" "ipc" "launcher" "toggle";
      repeat = false;
    };

    ### Focus / scroll
    "Mod+WheelScrollDown".action = focus-column-right;
    "Mod+WheelScrollUp".action = focus-column-left;
    "Mod+Shift+WheelScrollDown".action = move-column-right;
    "Mod+Shift+WheelScrollUp".action = move-column-left;
    "Mod+Ctrl+WheelScrollDown".action = focus-workspace-down;
    "Mod+Ctrl+WheelScrollUp".action = focus-workspace-up;

    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Up".action = focus-window-or-workspace-up;
    "Mod+Down".action = focus-window-or-workspace-down;

    "Mod+Ctrl+Left".action = move-column-left;
    "Mod+Ctrl+Right".action = move-column-right;
    "Mod+Ctrl+Up".action = move-window-up;
    "Mod+Ctrl+Down".action = move-window-down;

    "Mod+Shift+Left".action = focus-monitor-left;
    "Mod+Shift+Right".action = focus-monitor-right;
    "Mod+Shift+Up".action = focus-monitor-up;
    "Mod+Shift+Down".action = focus-monitor-down;

    "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
    "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
    "Mod+Shift+Ctrl+Up".action = move-column-to-workspace-up;
    "Mod+Shift+Ctrl+Down".action = move-column-to-workspace-down;

    "Mod+Shift+Tab".action = move-workspace-to-monitor-next;
    "Mod+Home".action = focus-column-first;
    "Mod+End".action = focus-column-last;
    "Mod+Alt+Left".action = consume-or-expel-window-left;
    "Mod+Alt+Right".action = consume-or-expel-window-right;

    ### Layout & windows
    "Mod+Minus".action = switch-preset-window-width;
    "Mod+Shift+Minus".action = switch-preset-window-height;
    "Mod+q".action = close-window;
    "Mod+t".action = toggle-window-floating;
    "Mod+Ctrl+t".action = switch-focus-between-floating-and-tiling;
    "Mod+f".action = maximize-column;
    "Mod+Shift+f".action = expand-column-to-available-width;
    "Mod+Ctrl+f".action = fullscreen-window;
    "Mod+y".action = toggle-column-tabbed-display;
    "Mod+Tab".action = toggle-overview;

    "Mod+Escape" = {
      action = toggle-keyboard-shortcuts-inhibit;
      allow-inhibiting = false;
    };

    "Mod+Ctrl+Shift+q".action = quit;
    "Mod+Shift+p".action = power-off-monitors;

    ### Volume
    XF86AudioRaiseVolume = {
      action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
      allow-when-locked = true;
    };
    XF86AudioLowerVolume = {
      action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
      allow-when-locked = true;
    };
    XF86AudioMute = {
      action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
      allow-when-locked = true;
    };
    XF86AudioMicMute = {
      action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
      allow-when-locked = true;
    };
    "F9" = {
      action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
      allow-when-locked = true;
    };

    ### Media
    XF86AudioPlay = {
      action = spawn "playerctl" "play-pause";
      allow-when-locked = true;
    };
    XF86AudioStop = {
      action = spawn "playerctl" "stop";
      allow-when-locked = true;
    };
    XF86AudioPrev = {
      action = spawn "playerctl" "previous";
      allow-when-locked = true;
    };
    XF86AudioNext = {
      action = spawn "playerctl" "next";
      allow-when-locked = true;
    };

    ### Brightness
    XF86MonBrightnessUp = {
      action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
      allow-when-locked = true;
    };
    XF86MonBrightnessDown = {
      action = spawn "brightnessctl" "--class=backlight" "set" "10%-";
      allow-when-locked = true;
    };

    ### Cast & screenshots
    "Mod+s".action = set-dynamic-cast-window;
    "Mod+Ctrl+s".action = set-dynamic-cast-monitor;
    "Mod+Ctrl+Shift+s".action = clear-dynamic-cast-target;

    "Print".action.screenshot = {};
    "Mod+Print".action.screenshot-screen = {};
    "Shift+Print".action.screenshot-window = {};
  };
}
