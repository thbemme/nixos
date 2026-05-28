{
  config,
  gpuAcceleration,
  inputs,
  vars,
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
      catWidget.enable = true;
      emojiLauncher = {
        enable = true;
        settings = {
          noTrigger = false;
          trigger = ":";
        };
      };
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
        "blueman::Bluetooth Disabled"
        "easyeffects::Easy Effects"
        "steam"
        "udiskie"
      ];
      weatherLocation = "${vars.weatherLocation}";
      weatherCoordinates = "${vars.weatherCoordinates}";
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
          transparency = 0.5;
          leftWidgets = [
            "launcherButton"
            {
              id = "music";
              enabled = true;
              mediaSize = 1;
            }
          ];
          centerWidgets = [
            "workspaceSwitcher"
          ];
          rightWidgets =
            [
              "catWidget"
              "privacyIndicator"
              "weather"
              "systemTray"
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
              "clipboard"
              "notificationButton"
              "battery"
              "controlCenterButton"
              "clock"
              "powerMenuButton"
            ];
        }
      ];
    };
  };
}
