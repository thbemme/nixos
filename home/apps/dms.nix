{
  config,
  gpuAcceleration,
  inputs,
  ...
}: {
  imports = [
    inputs.danksearch.homeModules.default
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.dms-plugin-registry.modules.default
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

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
    };

    niri.includes.enable = false;

    # Core features
    enableSystemMonitoring = false; # System monitoring widgets (dgop)
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
      emojiLauncher.enable = true;
      dankActions.enable = true;
      dankBatteryAlerts = {
        enable = true;
        settings = {
          criticalThreshold = 10;
        };
      };
      niriWindows.enable = true;
    };
    session = {
      hiddenTrayIds = [
        "steam"
        "corectrl"
        "blueman::Bluetooth Disabled"
        "udiskie"
      ];
      weatherLocation = "Dresden, Germany";
      weatherCoordinates = "51.03784342840871, 13.762874829338783";
    };
    settings = {
      clockDateFormat = "ddd MMM d";
      groupWorkspaceApps = false;
      innerPadding = 0;
      launcherLogoMode = "os";
      launcherPluginVisibility = {
        dms_settings_search.allowWithoutTrigger = false;
      };
      maxWorkspaceIcons = "10";
      powerMenuDefaultAction = "suspend";
      scrollTitleEnabled = false;
      showOccupiedWorkspacesOnly = true;
      showWorkspaceApps = true;
      transparency = "0.8";
      widgetBackgroundColor = "sch";
      widgetColorMode = "default";
      widgetTransparency = "0.8";
      workspaceColorMode = "sc";
      workspaceUnfocusedColorMode = "sch";

      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [
            "all"
          ];
          showOnLastDisplay = true;
          leftWidgets = [
            "launcherButton"
          ];
          centerWidgets = [
            {
              id = "workspaceSwitcher";
              enabled = true;
            }
          ];
          rightWidgets =
            [
              {
                id = "privacyIndicator";
                enabled = true;
              }
              {
                id = "music";
                enabled = true;
                mediaSize = 1;
              }
              {
                id = "weather";
                enabled = true;
              }
              {
                id = "systemTray";
                enabled = true;
              }
              {
                id = "cpuTemp";
                enabled = true;
                minimumWidth = true;
              }
            ]
            ++ (
              if gpuAcceleration
              then [
                {
                  id = "gpuTemp";
                  enabled = true;
                  selectedGpuIndex = 0;
                  pciId = "1002:73df";
                }
              ]
              else []
            )
            ++ [
              {
                id = "clipboard";
                enabled = true;
              }
              {
                id = "notificationButton";
                enabled = true;
              }
              {
                id = "battery";
                enabled = true;
              }
              {
                id = "controlCenterButton";
                enabled = true;
              }
              {
                id = "clock";
                enabled = true;
              }
              {
                id = "powerMenuButton";
                enabled = true;
              }
            ];
        }
      ];
    };
  };
}
