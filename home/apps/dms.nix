{
  config,
  gpuAcceleration,
  inputs,
  lib,
  pkgs,
  vars,
  ...
}: {
  imports = [
    inputs.dux-calendar.homeModules.default
    #inputs.dux-files.homeModules.default
    inputs.dux-plugin-registry.nixosModules.default
    inputs.dux-search.homeModules.default
    inputs.dux-shell.homeModules.dank-material-shell
    inputs.dux-shell.homeModules.niri
  ];

  programs.dsearch = {
    enable = true;
    config = {
      max_file_bytes = 2097152; # 2MB
      worker_count = 4;
      index_all_files = true;
      auto_reindex = true;
      reindex_interval_hours = 24;
      index_paths = [
        {
          path = "${config.home.homeDirectory}";
          exclude_hidden = true;
          exclude_dirs = ["Android" "Games" ".git" "target" "dist" "bin" "obj" "build"];
        }
      ];
    };
  };

  programs.dank-calendar = {
    enable = true;
    systemd.enable = true;
    settings = {
      firstDayOfWeek = -1;
      showWeekNumbers = true;
      timeFormat = "24h";
      use24HourClock = true;
    };
  };

  #programs.dux-files = {
  #  enable = true;
  #};

  programs.dank-material-shell = {
    enable = true;
    quickshell.package = lib.hiPrio inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
    };

    niri.includes.enable = false;

    # Core features
    enableSystemMonitoring = true; # system monitoring widgets (dgop)
    enableVPN = false; # VPN management widget
    enableDynamicTheming = false; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = false; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)

    plugins = {
      calculator = {
        enable = true;
        settings = {
          calcEngine = "qalc";
        };
      };
      catWidget.enable = true;
      commandRunner.enable = true;
      emojiLauncher = {
        enable = true;
        settings = {
          noTrigger = false;
          trigger = ":";
        };
      };
      dankActions.enable = true;
      dankNotepadModule.enable = true;
      niriWindows.enable = true;
    };
    session = {
      hiddenTrayIds = [
        "blueman"
        "dank-calendar"
        "easyeffects"
        "steam"
        "udiskie"
      ];
      weatherLocation = "${vars.weatherLocation}";
      weatherCoordinates = "${vars.weatherCoordinates}";
    };
    settings = {
      lockScreenWidgetInstances = [
        {
          enabled = true;
          id = "lock_clock";
          widgetType = "desktopClock";
        }
        {
          enabled = true;
          id = "lock_date";
          widgetType = "lockDate";
        }
        {
          enabled = true;
          id = "lock_auth";
          widgetType = "lockAuth";
        }
        {
          enabled = true;
          id = "lock_notifications";
          widgetType = "lockNotifications";
        }
        {
          enabled = true;
          id = "lock_status";
          widgetType = "lockStatus";
        }
      ];

      greeterWidgetInstances = [
        {
          enabled = true;
          id = "lock_clock";
          widgetType = "desktopClock";
        }
        {
          enabled = true;
          id = "lock_date";
          widgetType = "lockDate";
        }
        {
          enabled = true;
          id = "lock_auth";
          widgetType = "lockAuth";
        }
        {
          enabled = true;
          id = "lock_status";
          widgetType = "lockStatus";
        }
        {
          enabled = true;
          id = "greeter_session";
          widgetType = "greeterSession";
          config = {
            displayPreferences = ["all"];
            syncPositionAcrossScreens = true;
          };
        }
      ];

      radiusStrength = 30;
      radiusMode = "scale";
      fixedRadius = 0;
      powerMenuDefaultAction = "suspend";
      dmsWindowsFloatingSeeded = ["niri"];
      chipSurfaceNestedColor = "sch";
      widgetBackgroundColor = "sch";
      widgetColorMode = "default";
      showWeekNumber = true;
      calendarBackend = "dankcal";
      systemTrayIconTintMode = "monochrome";

      controlCenterWidgets = [
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "user";
          row = 0;
          w = 4;
        }
        {
          col = 4;
          enabled = true;
          h = 1;
          id = "settings";
          row = 0;
          small = true;
          w = 1;
        }
        {
          col = 5;
          enabled = true;
          h = 1;
          id = "lock";
          row = 0;
          small = true;
          w = 1;
        }
        {
          col = 7;
          enabled = true;
          h = 1;
          id = "power";
          row = 0;
          small = true;
          w = 1;
        }
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "brightnessSlider";
          row = 1;
          w = 4;
        }
        {
          col = 4;
          enabled = true;
          h = 1;
          id = "volumeSlider";
          row = 1;
          w = 4;
        }
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "wifi";
          row = 2;
          w = 4;
        }
        {
          col = 4;
          enabled = true;
          h = 1;
          id = "bluetooth";
          row = 2;
          w = 4;
        }
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "audioOutput";
          row = 3;
          w = 4;
        }
        {
          col = 4;
          enabled = true;
          h = 1;
          id = "audioInput";
          row = 3;
          w = 4;
        }
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "darkMode";
          row = 4;
          w = 2;
        }
        {
          col = 2;
          enabled = true;
          h = 1;
          id = "nightMode";
          row = 4;
          w = 2;
        }
        {
          col = 4;
          enabled = true;
          h = 1;
          id = "doNotDisturb";
          row = 4;
          w = 2;
        }
        {
          col = 6;
          enabled = true;
          h = 1;
          id = "idleInhibitor";
          row = 4;
          w = 2;
        }
        {
          col = 6;
          enabled = true;
          h = 1;
          id = "edit";
          row = 0;
          small = true;
          w = 1;
        }
      ];

      scrollTitleEnabled = false;
      clockDateFormat = "ddd MMM d";

      dashCards = [
        {
          col = 0;
          h = 1;
          id = "clock";
          row = 0;
          w = 2;
        }
        {
          col = 2;
          h = 1;
          id = "weather";
          row = 0;
          w = 1;
        }
        {
          col = 3;
          h = 5;
          id = "notifications";
          row = 0;
          w = 3;
        }
        {
          col = 0;
          h = 3;
          id = "calendar";
          row = 1;
          w = 3;
        }
        {
          col = 0;
          h = 1;
          id = "sysmon";
          row = 4;
          w = 3;
        }
      ];

      dashOptions = {
        clock.tone = "";
        media.lyrics = false;
        weather.widgets = [
          {
            city = true;
            col = 0;
            h = 2;
            id = "conditions";
            row = 0;
            tone = "";
            w = 2;
          }
          {
            col = 2;
            forecast = "chart";
            h = 2;
            id = "hourly";
            row = 0;
            w = 2;
          }
          {
            col = 0;
            h = 2;
            id = "sun";
            row = 2;
            tone = "";
            w = 1;
          }
          {
            col = 1;
            h = 2;
            id = "moon";
            row = 2;
            tone = "";
            w = 1;
          }
          {
            col = 2;
            graphics = true;
            h = 2;
            id = "humidity";
            row = 2;
            tone = "";
            w = 1;
          }
          {
            col = 3;
            graphics = true;
            h = 2;
            id = "wind";
            row = 2;
            tone = "";
            w = 1;
          }
          {
            col = 1;
            forecast = "chart";
            h = 2;
            id = "daily";
            row = 4;
            w = 3;
          }
          {
            col = 0;
            graphics = true;
            h = 2;
            id = "precipitation";
            row = 4;
            tone = "";
            w = 1;
          }
        ];
      };

      acMonitorTimeout = 180;
      acLockTimeout = 3600;
      acSuspendTimeout = 3600;
      batteryMonitorTimeout = 60;
      batterySuspendTimeout = 900;
      batteryChargeLimit = 100;
      lockBeforeSuspend = true;
      loginctlLockIntegration = true;
      fadeToLockEnabled = true;
      fadeToLockGracePeriod = 5;
      fadeToDpmsEnabled = true;
      fadeToDpmsGracePeriod = 5;
      terminalsAlwaysDark = true;

      barConfigs = [
        {
          attachToScreenEdge = true;
          centerWidgets = [
            {
              groupWorkspaceApps = false;
              id = "workspaceSwitcher";
              maxWorkspaceIcons = "10";
              showOccupiedWorkspacesOnly = true;
              showWorkspaceApps = true;
              workspaceColorMode = "sc";
              workspaceIndicatorCompact = true;
              workspaceUnfocusedColorMode = "sch";
            }
          ];
          enabled = true;
          id = "default";
          innerPadding = 0;
          leftWidgets = [
            {
              id = "launcherButton";
              launcherLogoMode = "os";
            }
            {
              id = "music";
              mediaShowCoverArt = false;
              mediaShowLyrics = false;
              mediaSize = 1;
            }
          ];
          name = "Main Bar";
          position = 0;
          rightWidgets =
            [
              "catWidget"
              "privacyIndicator"
              "weather"
              {
                id = "systemTray";
                trayUseInlineExpansion = true;
              }
              {
                id = "cpuTemp";
                minimumWidth = true;
              }
            ]
            ++ (
              if gpuAcceleration
              then [
                {
                  id = "gpuTemp";
                  selectedGpuIndex = 0;
                  pciId = "1002:73df";
                }
              ]
              else []
            )
            ++ [
              "clipboard"
              "battery"
              "controlCenterButton"
              "clock"
              "powerMenuButton"
            ];
          screenPreferences = ["all"];
          showOnLastDisplay = true;
        }
      ];

      launcherPluginVisibility = {
        dms_settings_search.allowWithoutTrigger = false;
      };

      configVersion = 42;
    };
  };
}
