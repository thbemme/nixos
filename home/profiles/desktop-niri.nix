{
  config,
  inputs,
  pkgs,
  vars,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri.homeModules.niri
  ];

  programs.fuzzel = {
    enable = true;
    settings.colors = {
      background = "282a36dd";
      text = "f8f8f2ff";
      match = "8be9fdff";
      selection-match = "8be9fdff";
      selection = "44475add";
      selection-text = "f8f8f2ff";
      border = "bd93f9ff";
    };
    settings.main.font = "FiraCode Nerd Font:size=8";
  };

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    settings = {
      audio = {
        cavaFrameRate = 60;
        volumeOverdrive = true;
      };
      bar = {
        density = "compact";
        marginHorizontal = 0.2;
        marginVertical = 0.1;
        position = "bottom";
        showCapsule = false;
        showOutline = false;
        transparent = false;
        outerCorners = false;
        widgets = {
          center = [
            {
              id = "Tray";
              blacklist = [];
              colorizeIcons = false;
              drawerEnabled = false;
              hidePassive = false;
              pinned = [];
            }
            {
              id = "Workspace";
              characterCount = 10;
              colorizeIcons = false;
              enableScrollWheel = false;
              followFocusedScreen = false;
              hideUnoccupied = false;
              labelMode = "name";
              showApplications = false;
              showLabelsOnlyWhenOccupied = false;
            }
          ];
          left = [
            {
              id = "ControlCenter";
              colorizeDistroLogo = false;
              colorizeSystemIcon = "none";
              customIconPath = "";
              enableColorization = false;
              icon = "noctalia";
              useDistroLogo = true;
            }
            {id = "WallpaperSelector";}
            {
              id = "Spacer";
              width = 20;
            }
            {
              compactMode = false;
              id = "SystemMonitor";
              diskPath = "/persist";
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskUsage = true;
              showGpuTemp = true;
              showMemoryAsPercent = true;
              showMemoryUsage = true;
              showNetworkStats = true;
              usePrimaryColor = false;
            }
            {
              id = "AudioVisualizer";
              colorName = "primary";
              hideWhenIdle = false;
              width = 200;
            }
          ];
          right = [
            {
              id = "MediaMini";
              hideMode = "hidden";
              hideWhenIdle = false;
              maxWidth = 145;
              scrollingMode = "hover";
              showAlbumArt = false;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = false;
              useFixedWidth = false;
              visualizerType = "linear";
            }
            {
              id = "Spacer";
              width = 20;
            }
            {
              id = "Microphone";
              displayMode = "alwaysShow";
            }
            {
              id = "Volume";
              displayMode = "alwaysShow";
            }
            {
              id = "Brightness";
              displayMode = "alwaysShow";
            }
            {
              id = "Spacer";
              width = 20;
            }
            {
              id = "Battery";
              displayMode = "alwaysShow";
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
              warningThreshold = 20;
            }
            {
              id = "NotificationHistory";
              hideWhenZero = true;
              showUnreadBadge = true;
            }
            {
              id = "Clock";
              customFont = "";
              formatHorizontal = "ddd dd.MM. HH:mm:ss";
              formatVertical = "HH mm - dd MM";
              useCustomFont = false;
              usePrimaryColor = false;
            }
          ];
        };
      };
      colorSchemes = {
        predefinedScheme = "Ayu";
      };
      general = {
        animationSpeed = 1.5;
        radiusRatio = 0.4;
        shadowDirection = "center";
        shadowOffsetX = 0;
        shadowOffsetY = 0;
        showSessionButtonsOnLockScreen = false;
      };
      location = {
        firstDayOfWeek = 0;
        name = "Dresden, Germany";
      };
      systemMonitor = {
        enableNvidiaGpu = true;
      };
      ui = {
        fontDefault = "Adwaita Sans";
        fontFixed = "FiraCode Nerd Font";
        panelBackgroundOpacity = 1;
      };
      notifications.enabled = true;
      dock.enabled = false;
      wallpaper = {
        enabled = true;
        directory = "/home/${vars.user}/kbnetcloud/Wallpapers/Space";
      };
    };
  };

  home.packages = [
    pkgs.nirius
    pkgs.wl-clipboard-rs
  ];

  services.gnome-keyring.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.niri = {
      default = [
        "gtk"
        "gnome"
      ];
      "org.freedesktop.impl.portal.Access" = ["gtk"];
      "org.freedesktop.impl.portal.Notification" = ["gtk"];
      "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
      "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      "org.freedesktop.impl.portal.ScreenCast" = ["xdg-desktop-portal-gnome"];
      "org.freedesktop.impl.portal.Screenshot" = ["xdg-desktop-portal-gnome"];
    };
    extraPortals = [
      pkgs.gnome-keyring
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      environment = {
        "QT_QPA_PLATFORM" = "wayland";
        "XDG_SESSION_TYPE" = "wayland";
        "NIXOS_OZONE_WL" = "1";
        "MOZ_ENABLE_WAYLAND" = "1";
        "MOZ_WEBRENDER" = "1";
        "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
        "GDK_BACKEND" = "wayland";
      };

      overview.workspace-shadow.enable = false;
      debug.honor-xdg-activation-with-invalid-serial = [];
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/screenshots/%Y-%m-%dT%H:%M:%S%:z.png";
      hotkey-overlay.skip-at-startup = true;

      input = {
        keyboard = {
          xkb = {
            layout = "de";
            variant = "nodeadkeys";
          };

          repeat-delay = 235;
          repeat-rate = 60;
          numlock = true;
        };

        touchpad = {
          tap = true;
          dwt = true;
          dwtp = true;
          natural-scroll = false;
          accel-profile = "flat";
        };

        mouse = {
          accel-speed = -0.5;
          accel-profile = "flat";
        };

        power-key-handling.enable = false;
        workspace-auto-back-and-forth = false;
      };

      gestures.hot-corners.enable = false;

      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "ghostty";
        "Mod+b".action = spawn "librewolf";
        "Menu".action = spawn "fuzzel";
        "Mod+d".action = spawn "fuzzel";
        "Mod+Alt+l".action = spawn "swaylock";

        "Mod+q".action = close-window;
        "Mod+t".action = toggle-window-floating;
        "Mod+Ctrl+t".action = switch-focus-between-floating-and-tiling;
        "Mod+f".action = maximize-column;
        "Mod+Shift+f".action = expand-column-to-available-width;
        "Mod+Ctrl+f".action = fullscreen-window;

        "Mod+Escape" = {
          action = toggle-keyboard-shortcuts-inhibit;
          allow-inhibiting = false;
        };

        # The quit action will show a confirmation dialog to avoid accidental exits.
        "Mod+Ctrl+Shift+q".action = quit;
        # Powers off the monitors. To turn them back on, do any input like
        # moving the mouse or pressing any other key.
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
        "Mod+MouseForward" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          allow-when-locked = true;
        };
      };

      window-rules = [
        {
          opacity = 0.95;
        }
        {
          matches = [{app-id = "com.mitchellh.ghostty";}];
          draw-border-with-background = false;
          opacity = 0.8;
        }
        {
          matches = [{app-id = "librewolf";}];
          open-on-workspace = "browser";
          open-maximized = true;
        }
      ];

      layout = {
        gaps = 1;
        center-focused-column = "never";
        empty-workspace-above-first = true;
        background-color = "transparent";

        preset-column-widths = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];

        default-column-width = {
          proportion = 0.5;
        };

        preset-window-heights = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];

        focus-ring = {
          enable = true;
          width = 2;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };

        border = {
          enable = false;
          width = 2;
          active.color = "#ffc87f";
          inactive.color = "#505050";
        };

        shadow = {
          # on
          softness = 30;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          draw-behind-window = true;
          color = "#00000070";
          # inactive-color "#00000054"
        };

        tab-indicator = {
          # off
          hide-when-single-tab = true;
          place-within-column = true;
          gap = 5;
          width = 4;
          length = {
            total-proportion = 1.0;
          };
          position = "right";
          gaps-between-tabs = 2;
          corner-radius = 8;
          active.color = "red";
          inactive.color = "gray";
        };

        insert-hint = {
          # off
          display.color = "#ffc87f80";
        };
      };
    };
  };
}
