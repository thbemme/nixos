{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      overview = {
        workspace-shadow.enable = true;
        zoom = 0.2;
        backdrop-color = config.lib.stylix.colors.withHashtag.base00;
      };
      debug.honor-xdg-activation-with-invalid-serial = [];
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/screenshots/%Y-%m-%dT%H:%M:%S%:z.png";
      hotkey-overlay.skip-at-startup = true;

      input = {
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "90%";
        };
        warp-mouse-to-focus.enable = false;
        workspace-auto-back-and-forth = true;
        keyboard = {
          xkb = {
            layout = "de";
            variant = "nodeadkeys";
            options = "caps:none";
          };
          repeat-delay = 235;
          repeat-rate = 60;
          numlock = true;
        };
        touchpad = {
          tap = true;
          dwt = true;
          dwtp = true;
          natural-scroll = true;
          accel-profile = "flat";
        };
        mouse = {
          accel-profile = "flat";
        };
        power-key-handling.enable = false;
      };

      outputs = {
        "LG Electronics LG ULTRAGEAR 204NTWG14769" = {
          variable-refresh-rate = "on-demand";
        };
      };

      gestures.hot-corners.enable = false;

      spawn-at-startup = [
        {command = ["ghostty" "-e" "rmpc"];}
        {command = ["ghostty" "-e" "btop"];}
        {command = ["librewolf"];}
        {command = ["zeditor"];}
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "ghostty";
        "Mod+b".action = spawn "librewolf";
        "Mod+Shift+b".action = spawn "tor-browser";
        "Mod+n".action = spawn "nautilus";
        "Mod+Shift+n".action = spawn "ghostty" "-e" "yazi";
        "Mod+v".action = spawn "dms" "ipc" "notepad" "toggle";
        "Mod+Shift+v".action = spawn "ghostty" "-e" "nvim";
        "Menu".action = spawn "dms" "ipc" "launcher" "toggle";
        "Mod+Space".action = spawn "dms" "ipc" "launcher" "toggle";
        #"Mod".release = toggle-overview; # https://github.com/niri-wm/niri/pull/2456
        "Mod+Alt+l".action = spawn "loginctl" "lock-session";
        "Mod+c".action = spawn "dcal" "toggle";

        "Mod+WheelScrollDown".action = focus-column-right;
        "Mod+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+WheelScrollUp".action = move-column-left;
        "Mod+Shift+WheelScrollDown".action = focus-workspace-down;
        "Mod+Shift+WheelScrollUp".action = focus-workspace-up;

        "Mod+Minus".action = switch-preset-window-width;
        "Mod+Shift+Minus".action = switch-preset-window-height;

        "Mod+q".action = close-window;
        "Mod+t".action = toggle-window-floating;
        "Mod+Ctrl+t".action = switch-focus-between-floating-and-tiling;
        "Mod+f".action = maximize-column;
        "Mod+Shift+f".action = expand-column-to-available-width;
        "Mod+Ctrl+f".action = fullscreen-window;

        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Down".action = focus-window-or-workspace-down;

        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Down".action = move-window-down;

        "Mod+Ctrl+Left".action = focus-monitor-left;
        "Mod+Ctrl+Right".action = focus-monitor-right;
        "Mod+Ctrl+Up".action = focus-monitor-up;
        "Mod+Ctrl+Down".action = focus-monitor-down;

        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+Up".action = move-column-to-workspace-up;
        "Mod+Shift+Ctrl+Down".action = move-column-to-workspace-down;

        "Mod+Tab".action = toggle-overview;
        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Alt+Left".action = consume-or-expel-window-left;
        "Mod+Alt+Right".action = consume-or-expel-window-right;
        "Mod+y".action = toggle-column-tabbed-display;

        "Mod+Escape" = {
          action = toggle-keyboard-shortcuts-inhibit;
          allow-inhibiting = false;
        };

        "Mod+Ctrl+Shift+q".action = quit;
        "Mod+Shift+p".action = power-off-monitors;

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
        "f9" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          allow-when-locked = true;
        };
        "Mod+MouseForward" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          allow-when-locked = true;
        };
        XF86AudioPlay = {
          action = spawn "playerctl play-pause";
          allow-when-locked = true;
        };
        XF86AudioStop = {
          action = spawn "playerctl stop";
          allow-when-locked = true;
        };
        XF86AudioPrev = {
          action = spawn "playerctl previous";
          allow-when-locked = true;
        };
        XF86AudioNext = {
          action = spawn "playerctl next";
          allow-when-locked = true;
        };
        XF86MonBrightnessUp = {
          action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
          allow-when-locked = true;
        };
        XF86MonBrightnessDown = {
          action = spawn "brightnessctl" "--class=backlight" "set" "10%-";
          allow-when-locked = true;
        };
        "Mod+s".action = set-dynamic-cast-window;
        "Mod+Ctrl+s".action = set-dynamic-cast-monitor;
        "Mod+Ctrl+Shift+s".action = clear-dynamic-cast-target;

        "Print".action.screenshot = {};
        "Mod+Print".action.screenshot-screen = {};
        "Shift+Print".action.screenshot-window = {};
        "Ctrl+Alt+Delete".action = spawn "dms" "ipc" "powermenu" "toggle";
      };

      workspaces = {
        "1".name = "gaming";
        "2".name = "main";
        "3".name = "dev";
        "4".name = "comm";
        "5".name = "office";
      };

      blur = {
        passes = 2;
        offset = 5;
        noise = 0.015;
        saturation = 1.25;
      };

      window-rules = [
        {
          geometry-corner-radius = let
            radius = 4.0;
          in {
            bottom-left = radius;
            bottom-right = radius;
            top-left = radius;
            top-right = radius;
          };
          clip-to-geometry = true;
        }
        {
          matches = [{is-window-cast-target = true;}];
          shadow = {
            enable = true;
            color = config.lib.stylix.colors.withHashtag.base08;
            spread = 2;
            softness = 0;
            offset = {
              x = 0;
              y = 0;
            };
          };
        }
        {
          matches = [{is-active = false;}];
          opacity = 0.95;
          background-effect.blur = true;
        }
        {
          matches = [{app-id = "com.mitchellh.ghostty";}];
          draw-border-with-background = false;
          opacity = 0.90;
          background-effect.blur = true;
          open-on-workspace = "main";
        }
        {
          matches = [
            {
              app-id = "^librewolf$";
              title = "^(Picture-in-Picture|Library|About LibreWolf)$";
            }
            {
              app-id = "^dev\\.zed\\.Zed$";
              title = "Zed — Settings";
            }
            {
              app-id = "org.remmina.Remmina";
              title = "Remmina Remote Desktop Client";
            }
            {app-id = ".blueman-manager-wrapped";}
            {app-id = "com.nextcloud.desktopclient.nextcloud";}
            {app-id = "mpv";}
            {app-id = "qalculate-gtk";}
            {app-id = "com.danklinux.dankcalendar";}
            {title = "^Open File";}
            {title = "^Open Folder";}
            {title = "^Rename \"";}
            {title = "^File Operation Progress";}
          ];
          open-floating = true;
        }
        {
          matches = [{app-id = "^librewolf$";}];
          open-maximized = true;
          open-on-workspace = "main";
        }
        {
          matches = [{app-id = "steam";} {app-id = "net.lutris.Lutris";}];
          open-on-workspace = "gaming";
        }
        {
          matches = [{app-id = "^steam_app_";} {app-id = "^rusty-path-of-building-";} {app-id = "\.exe$";}];
          open-maximized = true;
          open-on-workspace = "gaming";
        }
        {
          matches = [
            {
              app-id = "steam";
              title = "^notificationtoasts_\\d+_desktop$";
            }
          ];
          default-floating-position = {
            x = 10;
            y = 10;
            relative-to = "bottom-right";
          };
        }
        {
          matches = [{app-id = "^dev\\.zed\\.Zed$";} {app-id = "codium";} {app-id = "VSCodium";} {app-id = "Thonny";} {app-id = "jetbrains-studio";}];
          open-maximized = true;
          open-on-workspace = "dev";
        }
        {
          matches = [{app-id = "io.github.tdesktop_x64.TDesktop";} {app-id = "telegram-desktop";} {app-id = "wasistlos";} {app-id = "element";}];
          open-maximized = true;
          open-on-workspace = "comm";
        }
        {
          matches = [{app-id = "^libreoffice-";} {app-id = "^gimp";} {app-id = "lyx";} {app-id = "scribus";} {app-id = "krita";} {app-id = "org.gnome.SimpleScan";}];
          open-maximized = true;
          open-on-workspace = "office";
        }
        {
          matches = [{app-id = "^dev\\.zed\\.Zed$";} {app-id = "codium";} {app-id = "org.gnome.Nautilus";} {app-id = "qalculate-gtk";} {app-id = "VSCodium";} {app-id = "com.danklinux.dankcalendar";} {app-id = "com.danklinux.dms";}];
          draw-border-with-background = false;
          opacity = 0.90;
          background-effect.blur = true;
        }
      ];

      layout = {
        gaps = 1;
        center-focused-column = "never";
        empty-workspace-above-first = true;
        background-color = "transparent";
        preset-column-widths = [{proportion = 1.0;} {proportion = 0.5;} {proportion = 0.66667;} {proportion = 0.33333;}];
        default-column-width = {proportion = 0.5;};
        preset-window-heights = [{proportion = 0.33333;} {proportion = 0.5;} {proportion = 1.0;}];
        border = {
          width = 2;
        };
        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          gap = 5;
          width = 4;
          length = {total-proportion = 1.0;};
          position = "right";
          gaps-between-tabs = 2;
          corner-radius = 8;
          active.color = "red";
          inactive.color = "gray";
        };
        insert-hint = {display.color = config.lib.stylix.colors.withHashtag.base08;};
      };
    };
  };
}
